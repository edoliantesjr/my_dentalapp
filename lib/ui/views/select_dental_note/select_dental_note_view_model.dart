import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/dental_notes/dental_notes.dart';

class SelectDentalNoteViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  List<DentalNotes> listOfUnpaidDentalNotes = [];

  Future<void> init(String patientId) async {
    setBusy(true);
    listOfUnpaidDentalNotes = (await apiService.getDentalNotesList(
        patientId: patientId, isPaid: false))!;
    setBusy(false);
  }
}
