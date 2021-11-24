import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  final sessionService = locator<SessionService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final logger = getLogger('LoginViewModel');
  bool autoValidate = false;
  bool isObscure = true;
  bool isShowIconVisible = false;

  Future<void> loginNow(
      {required String emailValue, required String passwordValue}) async {
    if (loginFormKey.currentState!.validate()) {
      dialogService.showDefaultLoadingDialog();

      var loginResult = await firebaseAuthService.loginWithEmail(
          email: emailValue, password: passwordValue);

      if (loginResult.success) {
        sessionService.saveSession(isRunFirstTime: false, isLoggedIn: true);
        final isAccountSetupDone = await apiService.checkUserStatus();
        logger.i('Checking User Account Details');
        if (isAccountSetupDone) {
          navigationService.popAllAndPushNamed(Routes.LandingPage);
        } else {
          navigationService.popAllAndPushNamed(Routes.SetUpUserView);
        }
      } else {
        navigationService.closeOverlay();
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

  void setShowIconVisibility(String passwordValue) {
    if (passwordValue.length > 0) {
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
