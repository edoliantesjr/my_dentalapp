import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/appointment_model/appoinment_model.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  final logger = getLogger('AppointmentModel', printCallingFunctionName: true);
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? userSubscription;
  UserModel? currentUser;
  List<AppointmentModel>? mockAppointments;

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

  Future<void> deleteThisFromList(int index) async {
    // await mockAppointment.removeAt(index);
    notifyListeners();
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
}
