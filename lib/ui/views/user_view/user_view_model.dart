import 'dart:async';
import 'dart:io';

import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/search_index/search_index.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/core/utility/image_selector.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../core/service/snack_bar/snack_bar_service.dart';
import '../../widgets/selection_date/selection_date.dart';
import '../../widgets/selection_list/selection_option.dart';

class UserViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final bottomSheetService = locator<BottomSheetService>();
  final dialogService = locator<DialogService>();
  final validatorService = locator<ValidatorService>();
  final searchIndexService = locator<SearchIndexService>();
  final snackBarService = locator<SnackBarService>();
  final fAuthService = locator<FirebaseAuthService>();
  final imageSelectorService = locator<ImageSelector>();
  final toastService = locator<ToastService>();

  UserModel? currentUser;
  StreamSubscription? userSub;
  final updateUserFormKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final genderController = TextEditingController();
  final positionController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumController.dispose();
    dateOfBirthController.dispose();
    genderController.dispose();
    positionController.dispose();
    super.dispose();
  }

  List<String> activeStatus = ['active', 'on leave'];
  String status = '';
  DateTime? birthDate;

  void setActiveStatus(String value) async {
    await apiService.updateUserStatus(
        userId: currentUser!.userId, status: value);
    notifyListeners();
  }

  void init(UserModel user) {
    currentUser = user;
    firstNameController.text = currentUser!.firstName;
    lastNameController.text = currentUser!.lastName;
    phoneNumController.text = currentUser!.phoneNum;
    dateOfBirthController.text =
        currentUser!.dateOfBirth.toDateTime()!.toStringDateFormat();
    birthDate = currentUser!.dateOfBirth.toDateTime()!;
    genderController.text = currentUser!.gender;
    positionController.text = currentUser!.position;

    notifyListeners();
    listenToUserChange();
    status = currentUser!.active_status;
  }

  void listenToUserChange() {
    apiService.getUserAccountDetails().listen((event) {
      userSub?.cancel();
      userSub = apiService.getUserAccountDetails().listen((event) {
        currentUser = event;
        notifyListeners();
      });
    });
  }

  Future<void> setGenderValue() async {
    final selectedGender =
        await bottomSheetService.openBottomSheet(const SelectionOption(
      options: ['Male', 'Female'],
      title: 'Select your gender',
    ));
    if (selectedGender != null) {
      genderController.text = selectedGender;
    }
  }

  Future<void> setBirthDateValue() async {
    final selectedBirthDate =
        await bottomSheetService.openBottomSheet(const SelectionDate(
      title: 'Select birth date',
    ));
    if (selectedBirthDate != null) {
      birthDate = selectedBirthDate!;
      dateOfBirthController.text =
          DateFormat.yMMMd().format(selectedBirthDate!);
    }
  }

  Future<void> setPositionValue() async {
    String? selectedPosition =
        await bottomSheetService.openBottomSheet(const SelectionOption(
      options: ['Doctor', "Staff"],
      title: 'Select your position',
    ));
    if (selectedPosition != null) {
      positionController.text = selectedPosition;
      notifyListeners();
    }
  }

  void updateUserInfo() async {
    dialogService.showConfirmDialog(
        title: 'Update User Info',
        middleText:
            'This will update your user information. Continue doing this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          if (updateUserFormKey.currentState!.validate()) {
            final userSearchIndex =  searchIndexService.setSearchIndex(
                string:
                    '${firstNameController.text} ${lastNameController.text}');
            final user = UserModel(currentUser!.userId,
                active_status: currentUser!.active_status,
                firstName: firstNameController.text,
                lastName: lastNameController.text,
                email: currentUser!.email,
                image: currentUser!.image,
                position: positionController.text,
                dateOfBirth: birthDate.toString() ,
                gender: genderController.text,
                appointments: [],
                fcmToken: [],
                searchIndex: userSearchIndex,
                phoneNum: phoneNumController.text);
            final updateUserQuery = await apiService.updateUserInfo(user: user);
            navigationService.pop();

            if (updateUserQuery.success) {
              snackBarService.showSnackBar(
                  message: 'User Updated', title: 'Success');
            } else {
              snackBarService.showSnackBar(
                  message: updateUserQuery.errorMessage!, title: 'Error');
            }
          }
        });
  }

  void logout() async {
    dialogService.showConfirmDialog(
        onCancel: () {
          navigationService.pop();
        },
        middleText:
            'This action will lets you log out your account from the app. Are you sure to continue?',
        title: 'Logout',
        mainOptionTxt: 'Logout',
        onContinue: () async {
          await fAuthService.logOut();
          navigationService.popAllAndPushNamed(Routes.Login);
        });
  }

  Future<void> updateUserImage() async {
    XFile? selectedImage;
    var selectedImageSource =
        await bottomSheetService.openBottomSheet(const SelectionOption(
      options: ['Gallery', 'Camera'],
      title: 'Select Image Source',
    ));

    //Condition to select Image Source
    if (selectedImageSource == 'Gallery') {
      selectedImage = await imageSelectorService.selectImageWithGallery();
    } else if (selectedImageSource == 'Camera') {
      selectedImage = await imageSelectorService.selectImageWithCamera();
    }

    if (selectedImage != null) {
      toastService.showToast(message: 'Image Uploading...');
      final imageResult = await apiService.uploadProfileImage(
          imageToUpload: File(selectedImage.path), imageFileName: 'user');
      if (imageResult.isUploaded) {
        final qRes = await apiService.updateUserPhoto(
            image: imageResult.imageUrl!, userId: currentUser!.userId);
        if (qRes.success) {
          await Future.delayed(const Duration(seconds: 2));
          snackBarService.showSnackBar(
              message: 'User Image Updated', title: 'Success');
        } else {
          snackBarService.showSnackBar(
              message: 'User Image Not Updated: ${qRes.errorMessage!}',
              title: 'Error');
        }
      }
    }
  }
}
