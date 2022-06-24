import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/dental_notes/dental_notes.dart';
import 'package:stacked/stacked.dart';

class ViewDentalNoteByToothViewModel extends BaseViewModel {
//
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();

  List<DentalNotes> dentalNotes = [];
  Future<void> getDentalNoteByID(
    String selectedTooth,
    String patientId,
  ) async {
    setBusy(true);
    final notes = await apiService.getDentalNotesList(
        patientId: patientId, toothId: selectedTooth);
    await Future.delayed(const Duration(seconds: 1));
    if (notes != null) {
      dentalNotes.clear();
      dentalNotes = notes;
      notifyListeners();
    }

    setBusy(false);
  }
}
