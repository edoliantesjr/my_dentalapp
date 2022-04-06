import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:stacked/stacked.dart';

class PatientsViewModel extends BaseViewModel {
//  Todo: logic code for Patients View
  List<Patient> patientList = [];
  StreamSubscription? patientSub;
  final apiService = locator<ApiService>();
  final toastService = locator<ToastService>();
  final urlLauncherService = locator<URLLauncherService>();

  void getPatientList() {
    apiService.getPatients().listen((event) {
      patientSub?.cancel();
      patientSub = apiService.getPatients().listen((myPatientList) {
        patientList = myPatientList;
        notifyListeners();
      });
    });
  }

  Future<void> searchPatient(String value) async {
    setBusy(true);
    if (value.isNotEmpty) {
      value.trim();
      value.toLowerCase();
      patientList = await apiService.searchPatient(value);
      notifyListeners();
    } else {
      getPatientList();
    }
    setBusy(false);
  }
}
