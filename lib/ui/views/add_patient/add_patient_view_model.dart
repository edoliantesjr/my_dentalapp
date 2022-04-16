import 'dart:io';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/search_index/search_index.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/core/utility/image_selector.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:dentalapp/ui/views/main_body/main_body_view_model.dart';
import 'package:dentalapp/ui/views/update_user_info/setup_user_viewmodel.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_list/selection_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddPatientViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();
  final imageSelectorService = locator<ImageSelector>();
  final logger = getLogger('AddPatientViewModel');
  final apiService = locator<ApiService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final searchIndexService = locator<SearchIndexService>();

  bool haveAllergies = false;
  bool isMinor = false;
  XFile? patientSelectedImage;
  String? tempGender;
  DateTime? tempBirthDate;
  List<XFile> listOfMedicalHistory = [];

  bool autoValidate = false;

  void setAllergyVisibility(bool value) {
    if (haveAllergies) {
      haveAllergies = false;
    } else {
      haveAllergies = true;
    }
    notifyListeners();
  }

  Future<void> setGenderValue(
      TextEditingController textEditingController) async {
    String selectedGender =
        await bottomSheetService.openBottomSheet(SelectionOption(
              options: SetupUserViewModel().genderOptions,
              title: 'Select gender',
            )) ??
            '';
    tempGender = selectedGender != '' ? selectedGender : tempGender ?? '';
    selectedGender = tempGender!;
    textEditingController.text = selectedGender;
    notifyListeners();
  }

  Future<void> setBirthDateValue(
      TextEditingController textEditingController) async {
    DateTime? selectedBirthDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Select birth date',
    ));
    tempBirthDate =
        selectedBirthDate != null ? selectedBirthDate : tempBirthDate;
    selectedBirthDate = tempBirthDate!;
    textEditingController.text = DateFormat.yMMMd().format(selectedBirthDate);
    ;
    notifyListeners();
  }

  Future<void> selectPatientImage() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: SetupUserViewModel().imageSourceOptions,
      title: 'Select Image Source',
    ));
    //Condition to select Image Source
    if (selectedImageSource == SetupUserViewModel().imageSourceOptions[0]) {
      tempImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource ==
        SetupUserViewModel().imageSourceOptions[1]) {
      tempImage = await imageSelectorService.selectImageWithCamera();
    }
    if (tempImage != null) {
      patientSelectedImage = tempImage;
      setBusy(false);
      logger.i('image selected');
    }
    imageCache!.clear();
    logger.i('image cache cleared');
  }

  Future<void> savePatient({
    required String firstName,
    required String lastName,
    required String gender,
    required String birthDate,
    required String phoneNum,
    required String address,
    required String allergies,
    String? notes,
    String? emergencyContactName,
    String? emergencyContactNumber,
  }) async {
    if (patientSelectedImage != null) {
      final patientRef = await apiService.createPatientID();
      dialogService.showDefaultLoadingDialog(barrierDismissible: false);
      final imageUploadResult = await apiService.uploadPatientProfileImage(
          patientId: patientRef.id,
          imageToUpload: File(patientSelectedImage!.path));

      if (imageUploadResult.isUploaded) {
        final patientSearchIndex = await searchIndexService.setSearchIndex(
            string: '$firstName $lastName');
        final result = await apiService.addPatient(
          patientRef: patientRef,
          patient: Patient(
              image: imageUploadResult.imageUrl ?? '',
              firstName: firstName,
              lastName: lastName,
              gender: gender,
              birthDate: birthDate,
              phoneNum: phoneNum,
              address: address,
              allergies: allergies,
              emergencyContactNumber: emergencyContactNumber ?? '',
              emergencyContactName: emergencyContactName ?? '',
              searchIndex: patientSearchIndex,
              notes: notes ?? ''),
        );

        if (result == null) {
          navigationService.closeOverlay();
          MainBodyViewModel().setSelectedIndex(2);
          navigationService.pop();
          snackBarService.showSnackBar(
              title: 'Success', message: 'New Patient Added!');
          logger.v('patient details saved');
        } else {
          navigationService.closeOverlay();
          snackBarService.showSnackBar(
              title: 'Error',
              message: "There's an error encountered with adding new patient!");
        }
      } else {
        navigationService.closeOverlay();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'Patient profile image is not set',
          title: 'Missing required Data');
    }
  }

  void selectMedicalHistoryFile() async {
    dynamic tempImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(SelectionOption(
      options: SetupUserViewModel().imageSourceOptions,
      title: 'Get Medical History From',
    ));

    if (selectedImageSource == SetupUserViewModel().imageSourceOptions[0]) {
      tempImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource ==
        SetupUserViewModel().imageSourceOptions[1]) {
      tempImage = await imageSelectorService.selectImageWithCamera();
    }
    if (tempImage != null) {
      listOfMedicalHistory.add(tempImage);
      notifyListeners();
    }
  }
}
