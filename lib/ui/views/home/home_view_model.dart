import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/connectivity/connectivity_service.dart';

class HomePageViewModel extends BaseViewModel {
  final logger = getLogger('AppointmentModel', printCallingFunctionName: true);
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final fAuthService = locator<FirebaseAuthService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();

  StreamSubscription? userSubscription;
  StreamSubscription? appointmentSubscription;
  UserModel? currentUser;
  List<AppointmentModel> myAppointments = [];

  Future<void> init() async {
    setBusy(true);
    getCurrentUser();
    setBusy(false);
  }

  @override
  void dispose() {
    userSubscription?.cancel();
    super.dispose();
  }

  Future<void> deleteThisFromList(int index, String appointmentId) async {
    dialogService.showConfirmDialog(
        title: 'Delete  appointment',
        middleText:
            'This action will delete the appointment permanently. Continue this action?',
        onCancel: () => navigationService.pop(),
        onContinue: () async {
          await apiService.deleteAppointment(appointmentId: appointmentId);
          navigationService.pop();
          toastService.showToast(message: 'Appointment deleted');
        });
  }

  void getCurrentUser() {
    apiService.getUserAccountDetails().listen((event) async {
      userSubscription =
          apiService.getUserAccountDetails().listen((user) async {
        await Future.delayed(Duration(milliseconds: 500));
        dialogService.showDefaultLoadingDialog();
        currentUser = user;
        await Future.delayed(Duration(milliseconds: 500));
        navigationService.pop();
        notifyListeners();
      });
    });
  }

  void logOut() async {
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

  void getAppointment() {
    apiService.getAppointmentToday().listen(
      (event) {
        appointmentSubscription?.cancel();
        appointmentSubscription =
            apiService.getAppointmentToday().listen((event) {
          myAppointments.clear();
          myAppointments.addAll(event);
          notifyListeners();
          // updateAppointmentList();
        });
      },
    );
  }

  updateAppointmentList() {
    for (AppointmentModel appointment in myAppointments) {
      myAppointments.removeWhere((element) =>
          (element.appointment_status == AppointmentStatus.Declined.name) ||
          (element.appointment_status == AppointmentStatus.Cancelled.name) ||
          (element.appointment_status == AppointmentStatus.Completed.name));
      notifyListeners();
    }
  }

  void goToNotificationView() {
    navigationService.pushNamed(Routes.NotificationView);
  }

  void goToUserView(UserModel user) {
    navigationService.pushNamed(Routes.UserView,
        arguments: UserViewArguments(user: user));
  }
}
