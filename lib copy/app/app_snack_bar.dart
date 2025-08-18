import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSnackBar {
  static void showGetXCustomSnackBar1({
    required String message,
    Color backgroundColor = Colors.red,
  }) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 2),
        borderRadius: 6,
      ),
    );
  }

  static Future<void> showGetXCustomSnackBar({
    required String message,
    Color backgroundColor = Colors.red,
  }) async {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        backgroundColor: backgroundColor,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 2),
        borderRadius: 6,
      ),
    );

    // Wait for snackbar to finish before proceeding
    await Future.delayed(const Duration(seconds: 2));
  }
}
