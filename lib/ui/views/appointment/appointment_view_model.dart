import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:ntp/ntp.dart';
import 'package:stacked/stacked.dart';

class AppointmentViewModel extends BaseViewModel {
  DateTime ntpDate = DateTime.now();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  List<AppointmentModel> appointmentList = [];

  Future<void> getDateFromNtp() async {
    ntpDate = await NTP.now();
    notifyListeners();
  }

  void goToSelectPatient() {
    navigationService.pushNamed(Routes.SelectPatientView);
  }

  Future<void> getAppointmentByDate(DateTime dateTime) async {
    //  todo: logic code to get appointment by date
    appointmentList =
        await apiService.getAppointmentAccordingToDate(date: dateTime);
    notifyListeners();
  }
}
