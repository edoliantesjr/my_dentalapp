// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarServiceImpl extends SnackBarService {
  @override
  Future<dynamic>? showSnackBar(
      {String? title, required String message, TextButton? mainButton}) {
    if (!Get.isSnackbarOpen)
      GetSnackBar(
        title: title,
        message: message,
        duration: const Duration(seconds: 3),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        backgroundColor: Colors.grey[800]!,
        snackStyle: SnackStyle.FLOATING,
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        animationDuration: const Duration(milliseconds: 300),
        borderRadius: 12,
        snackPosition: SnackPosition.TOP,
        mainButton: mainButton,
      ).show();
    return null;
  }

  void open() {
    Get.snackbar('title', 'message');
  }
}
