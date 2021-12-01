import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/enums/appointment_status.dart';
import 'package:dentalapp/models/appointment_model/appoinment_model.dart';
import 'package:stacked/stacked.dart';

class HomePageViewModel extends BaseViewModel {
  List<AppointmentModel> mockAppointment = [
    AppointmentModel(
      serviceTitle: 'Dental Cleaning',
      dateDay: '01',
      dateMonth: 'December',
      doctor: 'Dr. Hannah Grace Cagape',
      patient: 'Mary Jane Santos',
      status: AppointmentStatus.Ongoing.name,
    ),
    AppointmentModel(
      serviceTitle: 'Tooth Removal',
      dateDay: '02',
      dateMonth: 'December',
      doctor: 'Dr. Hannah Grace Cagape',
      patient: 'Cardo Dalisay',
      status: AppointmentStatus.Done.name,
    ),
    AppointmentModel(
      serviceTitle: 'Tooth Filling',
      dateDay: '03',
      dateMonth: 'December',
      doctor: 'Dr. Hannah Grace Cagape',
      patient: 'Cheryl Quisto',
      status: AppointmentStatus.Pending.name,
    ),
    AppointmentModel(
      serviceTitle: 'Tooth Removal',
      dateDay: '04',
      dateMonth: 'December',
      doctor: 'Dr. Hannah Grace Cagape',
      patient: 'Edmond Ibaoc',
      status: AppointmentStatus.Cancelled.name,
    ),
  ];

  final logger = getLogger('AppointmentModel', printCallingFunctionName: true);
  final dialogService = locator<DialogService>();
  final navigationService = locator<NavigationService>();

  Future<void> init() async {
    setBusy(true);
    await Future.delayed(Duration(milliseconds: 2000));
    setBusy(false);
  }

  Future<void> deleteThisFromList(int index) async {
    await mockAppointment.removeAt(index);
    notifyListeners();
    logger.i('Item Deleted');
  }
}
