import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:ntp/ntp.dart';
import 'package:stacked/stacked.dart';

class AppointmentViewModel extends BaseViewModel {
  DateTime ntpDate = DateTime.now();
  final navigationService = locator<NavigationService>();

  Future<void> getDateFromNtp() async {
    ntpDate = await NTP.now();
    notifyListeners();
  }

  void goToSelectPatient() {
    navigationService.pushNamed(Routes.SelectPatientView);
  }
}
