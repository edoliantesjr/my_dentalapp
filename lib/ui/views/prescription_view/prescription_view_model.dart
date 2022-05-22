import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../../models/patient_model/patient_model.dart';

class PrescriptionViewModel extends BaseViewModel {
//  todo
  final navigationService = locator<NavigationService>();

  void goToAddPrescription(Patient patient) {
    navigationService.pushNamed(Routes.AddPrescriptionView,
        arguments: AddPrescriptionViewArguments(patient: patient));
  }
}
