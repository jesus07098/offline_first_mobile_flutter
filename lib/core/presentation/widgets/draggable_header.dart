import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/app_colors.dart';

class DraggableHeader extends StatelessWidget {
  const DraggableHeader({Key? key, required this.title, required this.context})
      : super(key: key);

  final String title;
  final BuildContext context;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const _DraggableTopContainerWidget(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints(maxWidth: 30, maxHeight: 80),
                  splashColor: AppColors.transparent,
                  highlightColor: AppColors.transparent,
                  alignment: Alignment.topRight,
                  onPressed: () => context.pop(),
                  icon: const Icon(
                    FluentIcons.dismiss_24_filled,
                    size: 16,
                    color: AppColors.black,
                  ))
            ],
          ),
        ),
        const Divider(thickness: 0.5),
      ],
    );
  }
}

class _DraggableTopContainerWidget extends StatelessWidget {
  const _DraggableTopContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.grey500.withAlpha(70)),
        width: 46,
        height: 6);
  }
}
