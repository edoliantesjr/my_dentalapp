import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/navigation/navigation_service.dart';

class PatientDrawerViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final fAuthService = locator<FirebaseAuthService>();

  void goToClinicAppointment() {
    navigationService.pushNamed(Routes.AppointmentView);
  }

  void goToClinicPersonnel() {
    //
  }
  void goClinicProcedures() {
    navigationService.pushNamed(Routes.ProceduresView);
  }

  void logOut() {
    dialogService.showConfirmDialog(
        onCancel: () {
          navigationService.pop();
        },
        middleText:
            'This action wil log out your account from the app. Are you sure to continue?',
        title: 'Logout',
        mainOptionTxt: 'Logout',
        onContinue: () async {
          await fAuthService.logOut();
          navigationService.popAllAndPushNamed(Routes.Login);
        });
  }
}
