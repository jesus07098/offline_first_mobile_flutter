// import 'dart:io';

// import 'package:flutter/material.dart';

// import 'package:file_picker/file_picker.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:go_router/go_router.dart';

// import 'package:path_provider/path_provider.dart';

// import '../../../../core/config/theme/app_colors.dart';
// import '../../../../core/config/theme/app_fonts.dart';
// import '../../../../core/config/theme/app_values.dart';
// import '../../../../core/data/services/camera_gallery_service_impl.dart';
// import '../../../../core/presentation/widgets/widgets.dart';
// import '../../../../core/utils/icon_type_priority.dart';
// import '../../../home/presentation/views/views.dart';

// class FilesScreen extends StatelessWidget {
//   const FilesScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: true,
//         appBar: const AppBarCustom(
//           titleText: 'Adjuntar archivos',
//         ),
//         body: SafeArea(
//           top: false,
//           child: Column(
//             children: [
//               Expanded(
//                 child: ListView(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: AppMargin.m18),
//                   children: const [
//                     SectionDivider(title: 'Audios'),
//                     _ListTileFile(
//                       title: 'Audio23423.wav',
//                       icon: IconType.audio,
//                     ),
//                     SectionDivider(title: 'Documentos'),
//                     _ListTileFile(
//                       title: 'Audio23423.wav',
//                       icon: IconType.document,
//                     ),
//                     SectionDivider(title: 'Comentarios'),
//                     _ListTileFile(
//                       title: 'Audio23423.wav',
//                       icon: IconType.comment,
//                     ),
//                     SectionDivider(title: 'Fotos'),
//                     _ListTileFile(
//                       title: 'Audio23423.wav',
//                       icon: IconType.photo,
//                     ),
//                   ],
//                 ),
//               ),
//               const _TextField(isWritting: true)
//             ],
//           ),
//         ));
//   }
// }

// class _ListTileFile extends StatelessWidget {
//   const _ListTileFile({required this.title, required this.icon});
//   final String title;
//   final IconType icon;
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       contentPadding: EdgeInsets.zero,
//       leading: Container(
//           padding: const EdgeInsets.all(12),
//           decoration: const BoxDecoration(
//               color: AppColors.grey100,
//               borderRadius: BorderRadius.all(Radius.circular(20))),
//           child: Icon(getIconByTypeFile(icon), color: AppColors.primaryColor)),
//       title: Text(title, style: getMediumStyle(fontSize: FontSize.s14)),
//       subtitle: Text('4 abr, 2023 8:00 PM | Size: 10 MB',
//           style: getRegularStyle(color: AppColors.grey500)),
//     );
//   }
// }

// class _TextField extends StatelessWidget {
//   const _TextField({this.isWritting = false});

//   final bool isWritting;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//           bottom: AppMargin.m10, left: AppMargin.m12, right: AppMargin.m12),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextFormField(
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   prefixIcon: IconButton(
//                       constraints: const BoxConstraints(maxHeight: 36),
//                       onPressed: () => showModalBottomSheet(
//                           backgroundColor: AppColors.transparent,
//                           context: context,
//                           builder: ((context) => SizedBox(
//                                 width: MediaQuery.of(context).size.width,
//                                 child: Card(
//                                     elevation: 0,
//                                     margin: const EdgeInsets.all(AppMargin.m18),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(30),
//                                       child: Wrap(
//                                         spacing: 25,
//                                         runSpacing: 20,
//                                         alignment: WrapAlignment.center,
//                                         children: [
//                                           ButtonOption(
//                                             label: 'Documentos',
//                                             icon:
//                                                 FluentIcons.document_20_filled,
//                                             onPressed: () async {
//                                               context.pop();
//                                               final result = await FilePicker
//                                                   .platform
//                                                   .pickFiles();
//                                               if (result == null) return;

//                                               final file = result.files.first;
//                                               // log('Name: ${file.name}');

//                                               // log('Name: ${file.extension}');
//                                               // openFile(file);
//                                               final newFile =
//                                                   await saveFilePermanently(file);
//                                               // log('From Path: ${file.path!}');
//                                               // log('From Path: ${newFile.path}');
//                                             },
//                                           ),
//                                           ButtonOption(
//                                             label: 'Cámara',
//                                             icon: FluentIcons.camera_20_filled,
//                                             onPressed: () =>
//                                                 CameraGalleryServiceImpl()
//                                                     .takePhoto(),
//                                           ),
//                                           ButtonOption(
//                                             label: 'Galería',
//                                             icon: FluentIcons.image_24_filled,
//                                             onPressed: () =>
//                                                 CameraGalleryServiceImpl()
//                                                     .selectPhotos(),
//                                           ),
//                                         ],
//                                       ),
//                                     )),
//                               ))),
//                       icon: const Icon(FluentIcons.add_24_filled, size: 24)),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(AppBorderRadius.br30),
//                     borderSide: const BorderSide(
//                       width: 0,
//                       style: BorderStyle.none,
//                     ),
//                   ),
//                   filled: true,
//                   contentPadding:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   fillColor: AppColors.grey200,
//                 )),
//           ),
//           IconButton(
//               onPressed: () {},
//               icon: Icon(isWritting == false
//                   ? FluentIcons.send_16_filled
//                   : FluentIcons.mic_24_filled)),
//         ],
//       ),
//     );
//   }

//   // void openFile(PlatformFile file) {
//   //   OpenFile.open(file.path!);
//   // }

//   Future<File> saveFilePermanently(PlatformFile file) async {
//     final appStorage = await getApplicationSupportDirectory();
//     final newFile = File('${appStorage.path}/${file.name}');
//     return File(file.path!).copy(newFile.path);
//   }
// }

// class ButtonOption extends StatelessWidget {
//   const ButtonOption(
//       {super.key, required this.label, this.onPressed, required this.icon});

//   final String label;
//   final void Function()? onPressed;
//   final IconData icon;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Container(
//           padding: const EdgeInsets.all(3),
//           decoration: BoxDecoration(
//               border: Border.all(color: AppColors.grey500),
//               borderRadius: BorderRadius.circular(60)),
//           child: IconButton(
//             onPressed: onPressed,
//             icon: Icon(icon, color: AppColors.grey700),
//           ),
//         ),
//         SizedBox(
//             width: 74,
//             child: Text(
//               textAlign: TextAlign.center,
//               label,
//               style: getRegularStyle(
//                   color: AppColors.grey500, overflow: TextOverflow.ellipsis),
//             ))
//       ],
//     );
//   }
// }

// TextFormField(),
