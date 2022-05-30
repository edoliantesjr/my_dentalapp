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
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_time/selection_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../models/notification/notification.dart';

class CreateAppointmentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final validatorService = locator<ValidatorService>();
  final snackBarService = locator<SnackBarService>();
  final dialogService = locator<DialogService>();

  String? tempDate;
  List<Procedure> selectedProcedures = [];
  DateTime? selectedAppointmentDate;
  DateTime? selectedStartTime;
  DateTime? selectedEndTime;
  DateTime? tempStartTime;
  DateTime? tempEndTime;
  UserModel? myDentist;
  AppointmentModel? latestAppointment;

  Future<void> setAppointment(
      {required AppointmentModel appointment, required int popTime}) async {
    try {
      dialogService.showDefaultLoadingDialog(
          willPop: false, barrierDismissible: false);
      final appointmentId = await apiService.createAppointment(appointment);
      navigationService.popUntilNamed(Routes.ViewPatientAppointment);
      snackBarService.showSnackBar(
          message:
              'Appointment Request was added. Waiting for approval by the dentist',
          title: 'Success');
      await getPersonnel();

      for (UserModel user in personnel) {
        final notification = NotificationModel(
          user_id: user.userId,
          notification_title: 'Appointment Request',
          notification_msg:
              'Patient ${appointment.patient.fullName.toUpperCase()}'
              ' has requested an appointment with'
              ' Doc. ${appointment.dentist} '
              'on ${appointment.date.toString().toDateTime()!.toStringDateFormat()}.',
          notification_type: 'appointment',
          isRead: false,
        );
        await apiService.saveNotification(
            notification: notification, typeId: appointmentId + user.userId);
        debugPrint('notification sent on ${user.fullName}');
      }
    } catch (e) {
      debugPrint(e.toString());
      navigationService.closeOverlay();
      toastService.showToast(message: "Something's wrong");
    }
  }

  List<UserModel> personnel = [];

  Future<void> getPersonnel() async {
    personnel = await apiService.getPersonnel();
    notifyListeners();
  }

  void selectDate(TextEditingController controller) async {
    selectedAppointmentDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set Appointment date',
      initialDate: DateTime.now(),
      maxDate: DateTime.utc(DateTime.now().year + 5),
    ));
    tempDate = selectedAppointmentDate != null
        ? selectedAppointmentDate.toString()
        : tempDate ?? '';
    selectedAppointmentDate = tempDate?.toDateTime()?.toDateMonthDayOnly() ??
        selectedAppointmentDate?.toDateMonthDayOnly();
    if (selectedAppointmentDate != null) {
      controller.text = DateFormat.yMMMd().format(selectedAppointmentDate!);
    }
    notifyListeners();
  }

  void selectStartTime(TextEditingController controller) async {
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
          controller.text = DateFormat.jm().format(selectedStartTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          controller.text = '';
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

  void selectEndTime(TextEditingController controller) async {
    if (selectedStartTime != null) {
      selectedEndTime = await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set End Time',
        initialDateTime: selectedStartTime!.add(Duration(minutes: 60)),
        minimumDateTime: selectedStartTime!.add(Duration(minutes: 5)),
      ));
      if (selectedEndTime != null) {
        if (selectedStartTime != selectedEndTime) {
          tempEndTime = selectedEndTime;
          controller.text = DateFormat.jm().format(selectedEndTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          controller.text = '';
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

  void openProcedureFullScreenModal(TextEditingController controller) async {
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

  void openDentistModal(TextEditingController controller) async {
    UserModel? selectedDentist =
        await navigationService.pushNamed(Routes.SelectionDentist);
    if (selectedDentist != null) {
      myDentist = selectedDentist;
      controller.text = selectedDentist.fullName;
      notifyListeners();
    }
  }

  void deleteSelectedProcedure(Procedure procedure) {
    selectedProcedures.removeWhere((element) => element.id == procedure.id);
    notifyListeners();
    toastService.showToast(message: 'Removed');
  }
}
