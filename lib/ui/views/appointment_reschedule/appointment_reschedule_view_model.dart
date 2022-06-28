import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/extensions/date_format_extension.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/notification/notification_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_time/selection_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AppointmentRescheduleViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final validatorService = locator<ValidatorService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  final createAppointmentFormKey = GlobalKey<FormState>();

  final dateTxtController = TextEditingController();
  final startTimeTxtController = TextEditingController();
  final endTimeTxtController = TextEditingController();
  final dentistTxtController = TextEditingController();
  final remarksTxtController = TextEditingController();
  final procedureTxtController = TextEditingController();

  @override
  void dispose() {
    dateTxtController.dispose();
    startTimeTxtController.dispose();
    endTimeTxtController.dispose();
    dentistTxtController.dispose();
    remarksTxtController.dispose();
    super.dispose();
  }

  String? tempDate;
  List<Procedure> selectedProcedures = [];
  DateTime? selectedAppointmentDate;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;
  DateTime? tempStartTime;
  DateTime? tempEndTime;
  String myDentist = '';

  void init(AppointmentModel appointment) {
    //
    selectedProcedures = List.from(appointment.procedures ?? []);
    selectedAppointmentDate = appointment.date.toDateTime();
    selectedStartTime = appointment.startTime.toDateTime();
    selectedEndTime = appointment.endTime.toDateTime();
    myDentist = appointment.dentist;
    // dateTxtController.text =
    //     DateFormat.yMMMd().format(selectedAppointmentDate!);
    startTimeTxtController.text = DateFormat.jm().format(selectedStartTime!);
    endTimeTxtController.text = DateFormat.jm().format(selectedEndTime!);
    dentistTxtController.text = myDentist;
  }

  Future<void> reSchedAppointment(
      {required AppointmentModel appointment,
      required int popTime,
      required String patientId}) async {
    try {
      if (selectedStartTime!.isAfter(selectedEndTime!)) {
        snackBarService.showSnackBar(
            message: 'Start time cannot be the set before End time',
            title: 'Warning');
      }
      if (selectedStartTime!.isAtSameMomentAs(selectedEndTime!)) {
        snackBarService.showSnackBar(
            message: 'Start time cannot be the same with End time',
            title: 'Warning');
      }
      if (selectedStartTime!.isBefore(selectedEndTime!)) {
        dialogService.showDefaultLoadingDialog(
            willPop: false, barrierDismissible: false);
        final appointmentId = await apiService.createAppointment(appointment);
        final notification = NotificationModel(
          user_id: patientId,
          notification_title: 'Appointment Rescheduled',
          notification_msg: 'Your Appointment '
              'with Doctor ${appointment.dentist}'
              ' has been rescheduled and set on '
              '${DateFormat.yMMMd().add_jm().format(appointment.date.toDateTime()!)} ',
          notification_type: 'appointment',
          isRead: false,
        );
        await apiService.saveNotification(
            notification: notification, typeId: appointmentId);
        navigationService.popRepeated(2);
        toastService.showToast(message: 'Appointment has been rescheduled!');
      }
    } catch (e) {
      debugPrint(e.toString());
      navigationService.closeOverlay();
      toastService.showToast(message: "Something's wrong");
    }
  }

  void selectDate() async {
    selectedAppointmentDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set Appointment date',
      initialDate: DateTime.now(),
      minDate: DateTime.now(),
      maxDate: DateTime.utc(DateTime.now().year + 5),
    ));
    tempDate = selectedAppointmentDate != null
        ? selectedAppointmentDate.toString()
        : tempDate ?? '';
    selectedAppointmentDate = tempDate?.toDateTime()?.toDateMonthDayOnly() ??
        selectedAppointmentDate?.toDateMonthDayOnly();
    if (selectedAppointmentDate != null) {
      dateTxtController.text =
          DateFormat.yMMMd().format(selectedAppointmentDate!);
    }
    notifyListeners();
  }

  void selectStartTime() async {
    if (selectedAppointmentDate != null) {
      selectedStartTime =
          await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set Start Time',
        initialDateTime: DateTime(selectedAppointmentDate!.year,
            selectedAppointmentDate!.month, selectedAppointmentDate!.day),
      ));
      if (selectedStartTime != null) {
        if (selectedEndTime != selectedStartTime) {
          tempStartTime = selectedStartTime;
          startTimeTxtController.text =
              DateFormat.jm().format(selectedStartTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          startTimeTxtController.text = '';
        }
      } else {
        selectedStartTime = tempStartTime;
        notifyListeners();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'Please Set Appointment Date First', title: 'Warning');
    }
  }

  void selectEndTime() async {
    if (selectedStartTime != null) {
      selectedEndTime = await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set End Time',
        initialDateTime: selectedStartTime!.add(const Duration(minutes: 60)),
        minimumDateTime: selectedStartTime!.add(const Duration(minutes: 5)),
      ));
      if (selectedEndTime != null) {
        if (selectedStartTime != selectedEndTime) {
          tempEndTime = selectedEndTime;
          endTimeTxtController.text = DateFormat.jm().format(selectedEndTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          endTimeTxtController.text = '';
        }
      } else {
        selectedEndTime = tempEndTime;
        notifyListeners();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'Please set start time first', title: 'Warning');
    }
  }

  void openProcedureFullScreenModal() async {
    Procedure? tempProcedure =
        await navigationService.pushNamed(Routes.SelectionProcedure);
    if (tempProcedure != null) {
      if (!(selectedProcedures
          .map((procedure) => procedure.id)
          .contains(tempProcedure.id))) {
        selectedProcedures.add(tempProcedure);
        notifyListeners();
      } else {
        toastService.showToast(message: 'Already Selected');
      }
    }
  }

  void openDentistModal() async {
    UserModel? selectedDentist =
        await navigationService.pushNamed(Routes.SelectionDentist);
    if (selectedDentist != null) {
      myDentist = selectedDentist.fullName;
      dentistTxtController.text = myDentist;
      notifyListeners();
    }
  }

  void deleteSelectedProcedure(Procedure procedure) {
    selectedProcedures.removeWhere((element) => element.id == procedure.id);
    notifyListeners();
    toastService.showToast(message: 'Removed');
  }
}
