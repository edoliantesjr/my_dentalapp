import 'dart:io';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/constants/database_strings/database_collection.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/core/utility/image_selector.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_list/selection_option.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';

class SetupUserViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final imageSelectorService = locator<ImageSelector>();
  final logger = getLogger('SetupUserViewModel');
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  final setupFormKey = GlobalKey<FormState>();

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> positionOptions = ['Admin/Doctor', 'Staff'];
  final List<String> imageSourceOptions = ['Gallery', 'Camera'];
  XFile? selectedImage;

  String? tempGender;

  Future<void> setGenderValue(
      TextEditingController textEditingController) async {
    String selectedGender =
        await bottomSheetService.openBottomSheet(SelectionOption(
              options: genderOptions,
              title: 'Select your gender',
            )) ??
            '';
    tempGender = selectedGender != '' ? selectedGender : tempGender ?? '';
    selectedGender = tempGender!;
    textEditingController.text = selectedGender;
    notifyListeners();
  }

  String? tempPosition;

  Future<void> setPositionValue(
      TextEditingController textEditingController) async {
    String selectedPosition =
        await bottomSheetService.openBottomSheet(SelectionOption(
              options: positionOptions,
              title: 'Select your position',
            )) ??
            '';
    tempPosition =
        selectedPosition != '' ? selectedPosition : tempPosition ?? '';
    selectedPosition = tempPosition!;
    textEditingController.text = selectedPosition;
    notifyListeners();
  }

  String? tempBirthDate;

  Future<void> setBirthDateValue(
      TextEditingController textEditingController) async {
    String selectedBirthDate =
        await bottomSheetService.openBottomSheet(SelectionDate()) ?? '';
    tempBirthDate =
        selectedBirthDate != '' ? selectedBirthDate : tempBirthDate ?? '';
    selectedBirthDate = tempBirthDate!;
    textEditingController.text = selectedBirthDate;
    notifyListeners();
  }

  Future<void> selectImageSource() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: imageSourceOptions,
      title: 'Select Image Source',
    ));

    //Condition to select Image Source
    if (selectedImageSource == imageSourceOptions[0]) {
      tempImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource == imageSourceOptions[1]) {
      tempImage = await imageSelectorService.selectImageWithCamera();
    }

    if (tempImage != null) {
      selectedImage = tempImage;

      setBusy(false);
      logger.i('image selected');
    }
    imageCache!.clear();
    logger.i('image cache cleared');
  }

  Future<void> saveUser(String firstName, String lastName, String dateOfBirth,
      String gender, String position) async {
    dialogService.showDefaultLoadingDialog(barrierDismissible: false);

    final imageUploadResult = await apiService.uploadProfileImage(
        imageToUpload: File(selectedImage!.path),
        imageFileName: selectedImage!.name);
    logger.i('image uploading');

    final userProfile = UserModel(currentFirebaseUser!.uid,
        firstName: firstName,
        lastName: lastName,
        email: currentFirebaseUser!.email!,
        image: imageUploadResult.imageUrl!,
        position: position,
        appointments: [],
        fcmToken: []);

    try {
      if (imageUploadResult.isUploaded) {
        logger.i('Image Uploaded');
        await apiService.createUser(userProfile);
        navigationService.closeOverlay();
        // snackBarService.showSnackBar('User Created Successfully!');
        navigationService.popAllAndPushNamed(Routes.Success);
        logger.i('User Created Successfully');
      } else {
        navigationService.closeOverlay();
        logger.e('Upload Image Failed');
        snackBarService.showSnackBar(imageUploadResult.message!);
      }
    } catch (e) {
      snackBarService.showSnackBar(
          "There's an error encountered on our end. Please try again later.");
    }
  }
}
