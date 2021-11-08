import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dialog_service.dart';

class DialogServiceImpl extends DialogService {
  @override
  Future showLoadingDialog({required String message, required bool willPop}) {
    return Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async {
          return willPop;
        },
        title: message,
        content: Center(
          child: Container(
            height: 50,
            width: 50,
            child: Column(
              children: [
                CircularProgressIndicator(
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Future showConfirmationDialog({
    required String title,
    required String middleText,
    required Function onCancel,
    required Function onContinue,
    required String textConfirm,
    required bool willPop,
  }) {
    return Get.defaultDialog(
      barrierDismissible: false,
      title: title,
      onWillPop: () async {
        return willPop;
      },
      middleText: middleText,
      onCancel: () => onCancel(),
      onConfirm: () => onContinue(),
      textCancel: 'Cancel',
      textConfirm: textConfirm,
      confirmTextColor: Colors.white,
    );
  }
}
