import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:stacked/stacked.dart';

class SelectPatientViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? patientSubscription;
  List<PatientModel> patientList = [];
  List<PatientModel> tempPatientList = [];

  void init() {
    apiService.getPatients().listen((event) {
      patientSubscription?.cancel();
      patientSubscription = apiService.getPatients().listen((event) {
        patientList = event;
        tempPatientList = patientList;
        notifyListeners();
      });
    });
  }

  Future<void> searchPatient(String value) async {
    setBusy(true);
    if (value.isNotEmpty) {
      patientList = await apiService.searchPatient(value);
      notifyListeners();
    } else {
      init();
    }
    setBusy(false);
  }
}
