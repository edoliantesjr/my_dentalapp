import 'dart:async';

import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/patient_model/patient_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../core/service/api/api_service.dart';
import '../../../core/service/dialog/dialog_service.dart';

class PatientInfoViewModel extends BaseViewModel {
  String age = '';
  ScrollController scrollController = ScrollController();
  final urlLauncher = locator<URLLauncherService>();
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final apiService = locator<ApiService>();
  StreamSubscription? patientInfoSub;

  Patient? patient;
  void init({required Patient patient}) async {
    this.patient = patient;
    listenToPatientInfoChange(patient: patient);
  }

  Future<void> getPatient({required Patient patient}) async {
    dialogService.showDefaultLoadingDialog();
    this.patient = await apiService.getPatientInfo(patientId: patient.id);
    notifyListeners();
    navigationService.pop();
  }

  void listenToPatientInfoChange({required Patient patient}) {
    apiService.listenToPatientChanges(patientId: patient.id).listen((event) {
      patientInfoSub?.cancel();
      patientInfoSub = apiService
          .listenToPatientChanges(patientId: patient.id)
          .listen((event) {
        getPatient(patient: patient);
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    patientInfoSub?.cancel();
    super.dispose();
  }

  void computeAge({required String birthDate}) {
    age = AgeCalculator.age(birthDate.toDateTime()!, today: DateTime.now())
        .years
        .toString();
    notifyListeners();
  }

  void callPatient(String phone) {
    urlLauncher.callPhoneNumber(phone: phone);
  }

  void textPatient(String phone) {
    urlLauncher.sendTextMessage(phone: phone);
  }

  void goToMedicalHistoryView({required dynamic patientId}) {
    navigationService.pushNamed(Routes.MedicalHistoryView,
        arguments: MedicalHistoryViewArguments(patientId: patientId));
  }

  void goToMedicalChart({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.PatientDentalChartView,
          arguments: PatientDentalChartViewArguments(patient: patient));
  }

  void goToViewPatientAppointmentView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.ViewPatientAppointment,
          arguments: ViewPatientAppointmentArguments(patient: patient));
  }

  void goToViewPatientPaymentsView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.ViewPatientPayment,
          arguments: ViewPatientPaymentArguments(patient: patient));
  }

  void goToPrescriptionView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.PrescriptionView,
          arguments: PrescriptionViewArguments(patient: patient));
  }

  void goToDentalCertificateView({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.DentalCertificationView,
          arguments: DentalCertificationViewArguments(patient: patient));
  }

  void goToUpdatePatient({required Patient? patient}) {
    if (patient != null)
      navigationService.pushNamed(Routes.EditPatientView,
          arguments: EditPatientViewArguments(patient: patient));
  }
}
