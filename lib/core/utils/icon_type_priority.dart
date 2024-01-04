import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class IconManager {
  static Map<String, IconData> priorities = {
    'Critica': FluentIcons.error_circle_20_filled,
    'Alta': FluentIcons.wifi_1_24_filled,
    'Media': FluentIcons.wifi_2_24_filled,
    'Baja': FluentIcons.wifi_3_24_filled,
    'No prioritaria': FluentIcons.border_none_20_filled,
  };

  static IconData getIconByTypePriority(String iconType) {
    return priorities[iconType] ?? FluentIcons.circle_small_24_regular;
  }
}
