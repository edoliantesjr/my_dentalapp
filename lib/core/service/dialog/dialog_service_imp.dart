import 'package:dentalapp/constants/styles/palette_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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

  @override
  Future<T?> showDefaultLoadingDialog<T>(
      {bool? barrierDismissible, bool? willPop}) {
    return Get.dialog(
      WillPopScope(
        onWillPop: () async {
          if (willPop != null) {
            if (willPop) {
              return true;
            } else {
              return false;
            }
          } else {
            return true;
          }
        },
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Palettes.kcNeutral1,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(8.sp),
            height: 75.sp,
            width: 70.sp,
            child: Center(
                child: LoadingAnimationWidget.flickr(
                    size: 30,
                    rightDotColor: Colors.white,
                    leftDotColor: Palettes.kcBlueMain2,
                    time: 1000)),
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: Palettes.kcBlueMain1.withOpacity(0.2),
    );
  }
}
