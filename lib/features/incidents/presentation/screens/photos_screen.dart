import 'dart:io';

import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:offline_first/core/presentation/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../../core/data/services/camera_gallery_service_impl.dart';
import '../../../../core/presentation/widgets/draggable_header.dart';
import '../../../../core/presentation/widgets/draggable_select_photo.dart';
import '../../../../core/utils/alerts.dart';
import '../blocs/incident_form/incident_form_bloc.dart';

class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key, required this.incidentContext, this.recordId});
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
  List<String> images = [];

  @override
  void initState() {
    images = List<String>.from(
        widget.incidentContext.watch<IncidentFormBloc>().state.photos!);
    FToast().init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final incidentFormBloc = widget.incidentContext.watch<IncidentFormBloc>();

    return ScaffoldCustom(
        appBar: const AppBarCustom(
          titleText: 'Fotos',
        ),
        body: incidentFormBloc.state.photos!.isNotEmpty
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemCount: incidentFormBloc.state.photos!.length,
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
                                          onTap: () => _openFile(
                                              incidentFormBloc
                                                  .state.photos![index])),
                                      ListTileOption(
                                          title: 'Borrar documento',
                                          icon: FluentIcons.delete_16_regular,
                                          onTap: () async {
                                            await _deletePhoto(
                                                index, incidentFormBloc);
                                            _removeImage(
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
                      decoration: BoxDecoration(
                          color: AppColors.grey100,
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(File(
                                  incidentFormBloc.state.photos![index])))),
                    ),
                  );
                })
            : const Center(
                child: Text('Aún no hay fotos'),
              ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(FluentIcons.add_12_filled, size: 22),
          onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => DraggableSelectPhoto(
                    takePhoto: () async {
                      context.pop();
                      final photoPath =
                          await CameraGalleryServiceImpl().takePhoto();
                      if (photoPath == null) return;

                      setState(() {
                        images.add(photoPath);
                      });

                      if (context.mounted) {
                        await _onPhotosChange(incidentFormBloc);
                        if (widget.recordId != null) {
                          incidentFormBloc.add(OnUpdatePhotos(
                              recordId: widget.recordId!,
                              photos: incidentFormBloc.state.photos ?? []));
                        }
                      }
                      AlertsManager.showToastCustom(
                          const ToastCustom(text: 'Cargando...'));
                    },
                    pickGallery: () async {
                      context.pop();

                      final photoPaths =
                          await CameraGalleryServiceImpl().selectPhotos();
                      if (photoPaths == null || photoPaths.isEmpty) return;

                      setState(() {
                        images.addAll(photoPaths);
                      });

                      if (context.mounted) {
                        await _onPhotosChange(incidentFormBloc);
                        if (widget.recordId != null) {
                          incidentFormBloc.add(OnUpdatePhotos(
                              recordId: widget.recordId!,
                              photos: incidentFormBloc.state.photos ?? []));
                        }
                      }
                    },
                  )),
        ));
  }

  void _removeImage(int index, IncidentFormBloc incidentFormBloc) async {
    context.pop();

    if (index < images.length) {
      setState(() {
        images.removeAt(index);
      });

      await _onPhotosChange(incidentFormBloc);
      if (widget.recordId != null) {
        incidentFormBloc.add(OnUpdatePhotos(
            recordId: widget.recordId!,
            photos: incidentFormBloc.state.photos ?? []));
      }
    }
  }

  Future<void> _onPhotosChange(IncidentFormBloc incidentFormBloc) async {
    incidentFormBloc.add(OnPhotosChange(images));
  }

  Future<void> _openFile(String filePath) async {
    context.pop();
    await OpenFilex.open(filePath);
  }

  Future<void> _deletePhoto(
      int index, IncidentFormBloc incidentFormBloc) async {
    incidentFormBloc
        .add(OnDeletePhoto(recordId: widget.recordId!, index: index));
  }
}
