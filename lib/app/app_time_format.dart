import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppTimePicker {
  static String currentTime12() {
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final String currentTime = timeFormat.format(DateTime.now());
    return currentTime;
  }

  static String currentTime24() {
    final DateFormat timeFormat = DateFormat('HH:mm:ss');
    final String currentTime = timeFormat.format(DateTime.now());
    return currentTime;
  }

  static String formatTime12(DateTime dateTime) {
    final DateFormat timeFormat = DateFormat('hh:mm a');
    final String selected = timeFormat.format(dateTime);
    return selected;
  }

  static String formatTime2(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final DateFormat timeFormat = DateFormat('hh:mm');
    final String selected = timeFormat.format(dateTime);
    return selected;
  }

  static String formatTime24(TimeOfDay timeOfDay) {
    return '${timeOfDay.hour}:${timeOfDay.minute.toString().padLeft(2, '0')}';
  }

  static void allTimeEnable24(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (timeOfDay != null) {
      controller.text = formatTime24(timeOfDay);
    }
  }

  static void allTimeEnable12(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // confirmText: "CONFIRM",
      // cancelText: "NOT NOW",
      // helpText: "BOOKING TIME"
    );

    // if (timeOfDay != null) {
    //   // ignore: use_build_context_synchronously
    //   controller.text = timeOfDay.format(context);
    // }

    if (timeOfDay != null) {
      controller.text = formatTime2(timeOfDay);
    }
  }
}
