import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_view.form.dart';

class LoginViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final log = getLogger('LoginViewModel');
  bool autoValidate = false;
  bool isObscure = true;
  bool isShowIconVisible = false;

  Future<void> loginNow() async {
    if (loginFormKey.currentState!.validate()) {
      dialogService.showDefaultLoadingDialog();
      var loginResult = await firebaseAuthService.loginWithEmail(
          email: emailValue ?? '', password: passwordValue ?? '');
      navigationService.closeOverlay();
      if (loginResult.success) {
        goToRegisterView();
      } else {
        snackBarService.showSnackBar(loginResult.errorMessage!);
      }
    } else {
      setAutoValidate();
    }
  }

  void goToRegisterView() {
    navigationService.pushNamed(Routes.Register);
  }

  void setAutoValidate() {
    autoValidate = true;
    notifyListeners();
  }

  void showHidePassword() {
    if (isObscure == true) {
      isObscure = false;
      notifyListeners();
    } else {
      isObscure = true;
      notifyListeners();
    }
  }

  void setShowIconVisibility() {
    if (passwordValue != null && passwordValue!.length > 1) {
      isShowIconVisible = true;
      notifyListeners();
    } else {
      isShowIconVisible = false;
      notifyListeners();
    }
  }

  @override
  void setFormStatus() {}
}
