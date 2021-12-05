import 'package:ntp/ntp.dart';
import 'package:stacked/stacked.dart';

class AppointmentViewModel extends BaseViewModel {
  DateTime ntpDate = DateTime.now();

  Future<void> getDateFromNtp() async {
    ntpDate = await NTP.now();
    notifyListeners();
  }
}
