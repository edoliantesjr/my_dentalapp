import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/dental_notes/dental_notes.dart';
import 'package:stacked/stacked.dart';

class ViewDentalNoteViewModel extends BaseViewModel {
  //
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<DentalNotes> dentalNotes = [];

  void getDentalNotes(String patientId) async {
    setBusy(true);
    final notes = await apiService.getDentalNotesList(patientId: patientId);

    await Future.delayed(const Duration(milliseconds: 500));

    if (notes != null) {
      dentalNotes.clear();
      dentalNotes.addAll(notes);
      notifyListeners();
    }
    setBusy(false);
  }
}
