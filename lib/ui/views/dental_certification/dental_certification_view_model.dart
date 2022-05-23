import 'dart:async';

import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/pdf_service/pdf_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../core/service/dialog/dialog_service.dart';
import '../../../models/dental_certificate/dental_certificate.dart';
import '../../../models/patient_model/patient_model.dart';

class DentalCertification extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final pdfService = locator<PdfService>();
  StreamSubscription? certSub;

  List<DentalCertificate> dentalCertificates = [];

  void goToAddCertificate(Patient patient) async {
    navigationService.pushNamed(Routes.AddCertificateView,
        arguments: AddCertificateViewArguments(patient: patient));
  }

  @override
  void dispose() {
    certSub?.cancel();
    super.dispose();
  }

  void getDentalCertificates({required Patient patient}) async {
    await Future.delayed(Duration(milliseconds: 300));
    dialogService.showDefaultLoadingDialog();
    final cert = await apiService.getDentalCert(patient: patient);
    dentalCertificates.clear();
    dentalCertificates.addAll(cert);
    navigationService.pop();
    notifyListeners();
  }

  void listenToGetDentalCert({required Patient patient}) {
    apiService.listenToDentalCertChanges(patient: patient).listen((event) {
      certSub?.cancel();
      certSub = apiService
          .listenToDentalCertChanges(patient: patient)
          .listen((event) {
        getDentalCertificates(patient: patient);
      });
    });
  }

  void openCertificate(
      {required DentalCertificate certificate,
      required Patient patient}) async {
    final pdf = await pdfService.printDentalCertificate(
        dentalCertificate: certificate, patient: patient);

    pdfService.savePdfFile(
        fileName: patient.fullName + '-Certificate-' + certificate.date,
        byteList: pdf);
  }
}
