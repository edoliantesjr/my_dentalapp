import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'snack_bar_service.dart';

class SnackBarServiceImpl extends SnackBarService {
  @override
  Future<dynamic>? showSnackBar(String message, {TextButton? mainButton}) {
    return GetBar(
            message: message,
            duration: Duration(seconds: 2, milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            backgroundColor: Colors.grey[800]!,
            snackStyle: SnackStyle.FLOATING,
            isDismissible: true,
            dismissDirection: SnackDismissDirection.HORIZONTAL,
            animationDuration: Duration(milliseconds: 400),
            borderRadius: 12,
            snackPosition: SnackPosition.TOP,
            mainButton: mainButton)
        .show();
  }

  void open() {
    Get.snackbar('title', 'message');
  }
}
