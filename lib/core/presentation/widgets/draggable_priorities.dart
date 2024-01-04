import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../config/theme/theme.dart';

import 'draggable_header.dart';

List<Map> priorities = [
  {
    'label': 'Critica',
    'icon': FluentIcons.error_circle_20_filled,
    'iconColor': AppColors.red500
  },
  {
    'label': 'Alta',
    'icon': FluentIcons.wifi_1_24_filled,
    'iconColor': AppColors.red900
  },
  {
    'label': 'Media',
    'icon': FluentIcons.wifi_2_24_filled,
    'iconColor': AppColors.orange400
  },
  {
    'label': 'Baja',
    'icon': FluentIcons.wifi_3_24_filled,
    'iconColor': AppColors.grey600
  },
  {
    'label': 'No prioritaria',
    'icon': FluentIcons.border_none_20_filled,
    'iconColor': AppColors.grey600
  },
];

class DraggablePriority extends StatefulWidget {
  const DraggablePriority({super.key, required this.onTap});
  final void Function(String) onTap;

  @override
  State<DraggablePriority> createState() => _DraggablePriorityState();
}

class _DraggablePriorityState extends State<DraggablePriority> {
  String selectedPriority = '';
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        minChildSize: 0.55,
        expand: false,
        initialChildSize: 0.55,
        builder: (context, _) => Column(
              children: [
                DraggableHeader(title: 'Prioridad', context: context),
                Expanded(
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p18),
                        itemCount: priorities.length,
                        itemBuilder: (context, index) {
                          final label = priorities[index]['label'];
                          final icon = priorities[index]['icon'];
                          final iconColor = priorities[index]['iconColor'];
                          return ListTile(
                            onTap: () {
                              setState(() {
                                selectedPriority = priorities[index]['label'];
                              });
                              widget.onTap(priorities[index]['label']);
                              context.pop();
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text(label),
                            trailing: Icon(icon, color: iconColor),
                            leading: RadioCustom(
                              value: priorities[index]['label'],
                              groupValue: selectedPriority,
                            ),
                          );
                        }))
              ],
            ));
  }
}

class RadioCustom extends StatelessWidget {
  const RadioCustom({
    super.key,
    required this.value,
    required this.groupValue,
  });

  final String value;
  final String groupValue;

  @override
  Widget build(BuildContext context) {
    return Radio(value: value, groupValue: groupValue, onChanged: (v) {});
  }
}
