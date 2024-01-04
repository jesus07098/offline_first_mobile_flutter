import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:record/record.dart';

import 'package:offline_first/core/presentation/widgets/draggable_header.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../../core/presentation/widgets/draggable_select_photo.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/presentation/widgets/widgets.dart'
    show ScaffoldCustom, AppBarCustom;
import '../../../../core/utils/alerts.dart';
import '../blocs/incident_form/incident_form_bloc.dart';

class AudiosScreen extends StatelessWidget {
  const AudiosScreen({super.key, required this.incidentContext, this.recordId});
  final BuildContext incidentContext;
  final String? recordId;
  @override
  Widget build(BuildContext context) {
    return _Scaffold(
      incidentContext: incidentContext,
      recordId: recordId,
    );
  }
}

class _Scaffold extends StatefulWidget {
  const _Scaffold({required this.incidentContext, required this.recordId});
  final BuildContext incidentContext;
  final String? recordId;
  @override
  State<_Scaffold> createState() => _ScaffoldState();
}

class _ScaffoldState extends State<_Scaffold> {
  List<String> _audiosPaths = [];
  late Record audioRecord;

  bool isRecording = false;
  String audioPath = '';

  @override
  void initState() {
    audioRecord = Record();
    _audiosPaths = List<String>.from(
        widget.incidentContext.watch<IncidentFormBloc>().state.audios ?? []);
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final incidentFormBloc = widget.incidentContext.watch<IncidentFormBloc>();

    return ScaffoldCustom(
        appBar: const AppBarCustom(
          titleText: 'Audios',
        ),
        body: incidentFormBloc.state.audios!.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: incidentFormBloc.state.audios!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => AlertsManager.showBottomSheetCustom(
                        context,
                        DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.5,
                            minChildSize: 0.5,
                            builder: (context, scrollController) =>
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      DraggableHeader(
                                          title: 'Opciones', context: context),
                                      ListTileOption(
                                        title: 'Escuchar audio',
                                        icon: FluentIcons.speaker_2_20_regular,
                                        onTap: () => _openFile(incidentFormBloc
                                            .state.audios![index]),
                                      ),
                                      ListTileOption(
                                          title: 'Borrar audio',
                                          icon: FluentIcons.delete_16_regular,
                                          onTap: () async {
                                            context.pop();
                                            await _deleteAudio(
                                                index, incidentFormBloc);

                                            _removeAudio(
                                                index, incidentFormBloc);
                                          }),
                                      ListTileOption(
                                        title: 'Cancelar',
                                        onTap: () => context.pop(),
                                      ),
                                    ],
                                  ),
                                ))),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.grey200,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(FluentIcons.mic_48_regular, size: 54),
                              const SizedBox(height: 6),
                              Expanded(
                                child: Text(
                                  File(incidentFormBloc.state.audios![index])
                                      .uri
                                      .pathSegments
                                      .last,
                                  style: getMediumStyle(),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            right: -6,
                            top: -6,
                            child: IconButton(
                                onPressed: () =>
                                    _removeAudio(index, incidentFormBloc),
                                icon: const Icon(
                                  Icons.cancel_sharp,
                                  color: AppColors.red900,
                                  size: 22,
                                )))
                      ],
                    ),
                  );
                })
            : const Center(
                child: Text('No hay audios aún'),
              ),
        floatingActionButton: FloatingActionButton(
            child: Icon(
                isRecording
                    ? FluentIcons.stop_24_filled
                    : FluentIcons.mic_24_filled,
                size: 22),
            onPressed: () => isRecording
                ? stopRecording(incidentFormBloc)
                : startRecording()));
  }

  void _removeAudio(int index, IncidentFormBloc incidentFormBloc) async {
    if (index < _audiosPaths.length) {
      // Elimina el audio de _audiosPaths

      setState(() {
        _audiosPaths.removeAt(index);
      });
      // Actualiza la lista de audios en el estado del bloc
      await _onAudiosChange(incidentFormBloc);
      if (widget.recordId != null) {
        // Actualiza la db on los audios correspondientes
        incidentFormBloc.add(OnUpdateAudios(
            recordId: widget.recordId!,
            audios: incidentFormBloc.state.audios ?? []));
      }
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      Exception(e);
    }
  }

  Future<void> stopRecording(IncidentFormBloc incidentFormBloc) async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        audioPath = path!;
        _audiosPaths.add(path);
      });

      await _onAudiosChange(incidentFormBloc);
      if (widget.recordId != null) {
        incidentFormBloc.add(OnUpdateAudios(
            recordId: widget.recordId!,
            audios: incidentFormBloc.state.audios ?? []));
      }
    } catch (e) {
      Exception('Error in Stopping record: $e');
    }
  }

  Future<void> _onAudiosChange(IncidentFormBloc incidentFormBloc) async {
    incidentFormBloc.add(OnAudiosChange(_audiosPaths));
    log(_audiosPaths.toString());
  }

  Future<void> _openFile(String filePath) async {
    context.pop();
    await OpenFilex.open(filePath);
  }

  Future<void> _deleteAudio(
      int index, IncidentFormBloc incidentFormBloc) async {
    incidentFormBloc
        .add(OnDeleteAudio(recordId: widget.recordId!, index: index));
  }
}
