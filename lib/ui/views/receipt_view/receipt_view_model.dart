import 'dart:typed_data';

import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';

class ReceiptViewModel extends BaseViewModel {
  final screenShotController = ScreenshotController();
  Uint8List? imageFile;
  final toastService = locator<ToastService>();
  final snackBarService = locator<SnackBarService>();

  void downloadReceipt(double pixelRatio) async {
    screenShotController
        .capture(
          delay: Duration(seconds: 1),
          pixelRatio: pixelRatio,
        )
        .then(
          (image) => imageFile = image,
        );
    if (imageFile != null) {
      if (await Permission.storage.request().isGranted) {
        await ImageGallerySaver.saveImage(imageFile!);
        snackBarService.showSnackBar(
            message: 'Image was saved to Gallery', title: 'Downloaded');
      } else if (await Permission.storage.request().isPermanentlyDenied) {
        await openAppSettings();
      } else if (await Permission.storage.request().isDenied) {
        toastService.showToast(message: 'Permission Denied');
      }
    }
  }
}
