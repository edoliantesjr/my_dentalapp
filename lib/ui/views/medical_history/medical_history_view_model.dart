import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/medical_history/medical_history.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class MedicalHistoryViewModel extends BaseViewModel {
//  Todo: logic code for medical history view model
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<MedicalHistory> medHistoryList = [];

  Future<void> getPatientMedicalHistory(String patientId) async {
    debugPrint('patient id is: $patientId');
    setBusy(true);
    medHistoryList =
        (await apiService.getPatientMedicalRecord(patientId: patientId))!;
    notifyListeners();
    setBusy(false);
  }

  void goToPhotoView({required int index}) {
    navigationService.pushNamed(Routes.MedHistoryPhotoView,
        arguments: MedHistoryPhotoViewArguments(
            medHistory: medHistoryList, initialIndex: index));
  }
}
