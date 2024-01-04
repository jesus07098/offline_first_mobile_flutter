import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/theme/theme.dart';
import '../../../../core/presentation/widgets/section_container.dart';

class TypeFileSelector extends StatelessWidget {
  const TypeFileSelector(
      {super.key,
      this.onTapPhotos,
      this.photosQuantity=0,
      this.audiosQuantity=0,
      this.documentsQuantity=0,
      this.onTapAudios,
      this.onTapDocuments});
  final void Function()? onTapPhotos;
  final void Function()? onTapAudios;
  final void Function()? onTapDocuments;
  final int? photosQuantity;
  final int? documentsQuantity;
  final int? audiosQuantity;
  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        children: [
          ListTile(
            minVerticalPadding: 0.0,
            horizontalTitleGap: 10,
            onTap: onTapPhotos,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            dense: true,
            title:
                Text('Fotos', style: getRegularStyle(fontSize: FontSize.s14)),
            leading: const Icon(FluentIcons.image_16_regular,
                color: AppColors.grey800, size: 22),
            trailing: Text(
              photosQuantity.toString(),
              style: getRegularStyle(),
            ),
          ),
          ListTile(
            minVerticalPadding: 0.0,
            horizontalTitleGap: 10,
            onTap: onTapAudios,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            dense: true,
            title:
                Text('Audios', style: getRegularStyle(fontSize: FontSize.s14)),
            leading: const Icon(FluentIcons.mic_16_regular,
                color: AppColors.grey800, size: 22),
            trailing: Text(
              audiosQuantity.toString(),
              style: getRegularStyle(),
            ),
          ),
          ListTile(
            minVerticalPadding: 0.0,
            horizontalTitleGap: 10,
            onTap: onTapDocuments,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
            dense: true,
            title: Text('Documentos',
                style: getRegularStyle(fontSize: FontSize.s14)),
            leading: const Icon(FluentIcons.document_16_regular,
                color: AppColors.grey800, size: 22),
            trailing: Text(
              documentsQuantity.toString(),
              style: getRegularStyle(),
            ),
          )
        ],
      ),
    );
  }
}
