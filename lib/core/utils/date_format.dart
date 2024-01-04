import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateManager {
  static String formatDate(DateTime? date, {bool visualFormat = false}) {
    final originalFormat = DateFormat('yyyy-MM-dd');
    final desiredFormat =
        visualFormat ? DateFormat('dd/MM/yyyy') : originalFormat;

    try {
      final parsedDate = originalFormat.parse(date.toString());
      final formattedDate = desiredFormat.format(parsedDate);
      return formattedDate.split(' ').first;
    } catch (e) {
      return date.toString();
    }
  }

  static String formatTime(TimeOfDay time) {
    return '${time.hour}:${time.minute} ${time.period.toString().split('.')[1]}';
  }

  static String formatTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    final days = difference.inDays;
    if (days == 1) {
      return 'hace $days día';
    }
    return 'hace $days días';
  }

  static String formatDateLageHuman(String date) {
    DateTime dateToFormat = DateTime.parse(date);

    // Definir el formato de salida
    final outputFormat = DateFormat('EEEE, MMM d, y', 'es');

    // Formatear la fecha
    return outputFormat.format(dateToFormat);
  }
}
