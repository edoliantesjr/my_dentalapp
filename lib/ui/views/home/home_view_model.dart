import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  final logger = getLogger('AppointmentModel', printCallingFunctionName: true);
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final fAuthService = locator<FirebaseAuthService>();
  final toastService = locator<ToastService>();
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
    await myAppointments.removeAt(index);
    await apiService.deleteAppointment(appointmentId: appointmentId);
    notifyListeners();
    toastService.showToast(message: 'Appointment Deleted');
    logger.i('Item Deleted');
  }

  void getCurrentUser() {
    apiService.getUserAccountDetails().listen((event) {
      userSubscription = apiService.getUserAccountDetails().listen((user) {
        currentUser = user;
        notifyListeners();
      });
    });
  }

  void logOut() async {
    await fAuthService.logOut();
    navigationService.popAllAndPushNamed(Routes.Login);
  }

  void getAppointment() {
    //  todo: logic code to get list of appointments
    apiService.searchAppointment(query: '').listen((event) {
      appointmentSubscription?.cancel();
      appointmentSubscription =
          apiService.searchAppointment(query: '').listen((event) {
        myAppointments = event;
        notifyListeners();
      });
    });
  }
}
