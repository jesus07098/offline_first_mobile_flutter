import 'package:flutter/material.dart';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_colors.dart';
import '../../config/theme/app_fonts.dart';
import 'draggable_header.dart';

class DraggableSelectPhoto extends StatelessWidget {
  const DraggableSelectPhoto({super.key, this.takePhoto, this.pickGallery});
  final void Function()? takePhoto;
   final void Function()? pickGallery;
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.35,
        maxChildSize: 0.35,
        minChildSize: 0.35,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
              child: Column(
                children: [
                  DraggableHeader(
                    context: context,
                    title: 'Cargar foto por:',
                  ),
                  ListTileOption(
                    title: 'Tomar foto',
                    icon: FluentIcons.camera_16_regular,
                  
                    onTap: takePhoto,
                  ),
                  ListTileOption(
                    title: 'Elegir una foto existente',
                    icon: FluentIcons.image_16_regular,
                       onTap: pickGallery,
                  ),
                  ListTileOption(
                    title: 'Cancelar',
                    icon: FluentIcons.dismiss_circle_16_regular,
                    onTap: () => context.pop(),
                    color: AppColors.red900,
                  )
                ],
              ),
            ));
  }
}

class ListTileOption extends StatelessWidget {
  const ListTileOption(
      {super.key, this.onTap,
      required this.title,
      this.icon,
      this.color = AppColors.black});
  final void Function()? onTap;
  final String title;
  final IconData? icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          icon != null ? Icon(icon, color: color) : const SizedBox(width: 10),
      onTap: onTap,
      dense: true,
      title: Text(title,
          style: getSemiBoldStyle(fontSize: FontSize.s14, color: color!)),
    );
  }
}
