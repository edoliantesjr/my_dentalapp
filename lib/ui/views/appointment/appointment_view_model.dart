import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:ntp/ntp.dart';
import 'package:stacked/stacked.dart';

class AppointmentViewModel extends BaseViewModel {
  DateTime? ntpDate;
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  DateTime selectedDate = DateTime.now();
  List<AppointmentModel> appointmentList = [];
  StreamSubscription? appointmentSub;

  Future<void> getDateFromNtp() async {
    ntpDate = await NTP.now();
    selectedDate = ntpDate ?? DateTime.now();

    notifyListeners();
  }

  void goToSelectPatient() {
    navigationService.pushNamed(Routes.SelectPatientView);
  }

  Future<void> getAppointmentByDate(DateTime? dateTime) async {
    setBusy(true);
    selectedDate = dateTime ?? DateTime.now();
    final tempList =
        await apiService.getAppointmentAccordingToDate(date: dateTime);
    appointmentList = tempList;
    notifyListeners();
    setBusy(false);
  }

  void listenToAppointmentChanges() async {
    apiService.listenToAppointmentChanges().listen((event) {
      appointmentSub =
          apiService.listenToAppointmentChanges().listen((event) async {
        await getAppointmentByDate(selectedDate);
      });
    });
  }
}
