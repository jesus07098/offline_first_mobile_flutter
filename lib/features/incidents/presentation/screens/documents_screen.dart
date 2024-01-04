import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:offline_first/core/config/theme/app_fonts.dart';
import 'package:offline_first/core/config/theme/app_values.dart';
import 'package:offline_first/core/presentation/widgets/draggable_header.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/presentation/widgets/draggable_select_photo.dart';
import '../../../../core/presentation/widgets/widgets.dart'
    show ScaffoldCustom, AppBarCustom;
import '../../../../core/utils/alerts.dart';
import '../blocs/incident_form/incident_form_bloc.dart';
import 'package:open_filex/open_filex.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen(
      {super.key, required this.incidentContext, this.recordId});
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
  List<String> _selectedFilePaths = [];

  @override
  void initState() {
    _selectedFilePaths = List<String>.from(
        widget.incidentContext.watch<IncidentFormBloc>().state.documents ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final incidentFormBloc = widget.incidentContext.watch<IncidentFormBloc>();

    return ScaffoldCustom(
        appBar: const AppBarCustom(
          titleText: 'Documentos',
        ),
        body: incidentFormBloc.state.documents!.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: incidentFormBloc.state.documents!.length,
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
                                        title: 'Ver documento',
                                        icon: Icons.visibility_outlined,
                                        onTap: () => _openFile(incidentFormBloc
                                            .state.documents![index]),
                                      ),
                                      ListTileOption(
                                          title: 'Borrar documento',
                                          icon: FluentIcons.delete_16_regular,
                                          onTap: () async {
                                            await removeFromDocument(
                                                index, incidentFormBloc);
                                            _removeDocument(
                                                index, incidentFormBloc);
                                          }),
                                      ListTileOption(
                                        title: 'Cancelar',
                                        onTap: () => context.pop(),
                                      ),
                                    ],
                                  ),
                                ))),
                    child: Container(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.grey200,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(FluentIcons.document_48_regular, size: 54),
                          const SizedBox(height: 6),
                          Expanded(
                            child: Text(
                              File(incidentFormBloc.state.documents![index])
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
                  );
                })
            : const Center(
                child: Text('No hay documentos aún'),
              ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(FluentIcons.add_12_filled, size: 22),
            onPressed: () => _pickFiles(incidentFormBloc)));
  }

  Future<void> _removeDocument(
      int index, IncidentFormBloc incidentFormBloc) async {
    context.pop();

    if (index < _selectedFilePaths.length) {
      setState(() {
        _selectedFilePaths.removeAt(index);
      });

      await _onDocumentsChange(incidentFormBloc);
      if (widget.recordId != null) {
        incidentFormBloc.add(OnUpdateDocuments(
            recordId: widget.recordId!,
            documents: incidentFormBloc.state.documents ?? []));
      }
    }
  }

  Future<void> _openFile(String filePath) async {
    context.pop();
    await OpenFilex.open(filePath);
  }

  Future<void> _onDocumentsChange(IncidentFormBloc incidentFormBloc) async {
    incidentFormBloc.add(OnDocumentsChange(_selectedFilePaths));
  }

  Future<void> _pickFiles(IncidentFormBloc incidentFormBloc) async {
    try {
      FilePickerResult? filesPickers = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.any,
      );
      if (filesPickers != null && context.mounted) {
        _selectedFilePaths
            .addAll(filesPickers.paths.map((path) => path!).toList());
        setState(() {});
        await _onDocumentsChange(incidentFormBloc);
        if (widget.recordId != null) {
          incidentFormBloc.add(OnUpdateDocuments(
              recordId: widget.recordId!,
              documents: incidentFormBloc.state.documents ?? []));
        }
      }
    } catch (e) {
      Exception(e);
    }
  }

  removeFromDocument(int index, IncidentFormBloc incidentFormBloc) {
    incidentFormBloc
        .add(OnDeleteDocument(recordId: widget.recordId!, index: index));
  }
}
