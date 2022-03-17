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
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:dentalapp/models/appointment_model/appointment_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_time/selection_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

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
  UserModel? myDentist;

  //Todo 1: set appointment date and time in sync
  //Todo 2: compare time of appointments
  //Todo 3: set minimum start time
  //Todo 4: get appointments of the selected appointment date
  // Todo 5: set minimum date to latest max end time
  //Todo 6: cant add appointment if selected time is already allotted to some else

  Future<void> setAppointment(AppointmentModel appointment) async {
    try {
      dialogService.showDefaultLoadingDialog(
          willPop: false, barrierDismissible: false);
      await apiService.createAppointment(appointment);
      toastService.showToast(message: 'Appointment added');
      navigationService.closeOverlay();
      navigationService.pop();
    } catch (e) {
      debugPrint(e.toString());
      navigationService.closeOverlay();
      toastService.showToast(message: "Something's wrong");
    }
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
    selectedAppointmentDate = tempDate?.toDateTime() ?? selectedAppointmentDate;
    controller.text = DateFormat.yMMMd().format(selectedAppointmentDate!);
    notifyListeners();
  }

  void selectStartTime(TextEditingController controller) async {
    if (selectedAppointmentDate != null) {
      selectedStartTime =
          await bottomSheetService.openBottomSheet(SelectionTime(
        title: 'Set Start Time',
        initialDateTime: selectedAppointmentDate,
      ));
      if (selectedStartTime != null ||
          selectedStartTime!.toString().trim() != '') {
        if (selectedEndTime != selectedStartTime) {
          controller.text = DateFormat.jm().format(selectedStartTime!);
        } else {
          snackBarService.showSnackBar(
              message: 'Start time cannot be the same with End time',
              title: 'Warning');
          controller.text = '';
        }
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
        initialDateTime: selectedAppointmentDate?.add(Duration(hours: 1)),
        minimumDateTime: selectedAppointmentDate?.add(Duration(minutes: 1)),
      ));
      if (selectedStartTime != null) {
        if (selectedEndTime != null || selectedEndTime != '') {
          if (selectedStartTime != selectedEndTime) {
            controller.text = DateFormat.jm().format(selectedEndTime!);
          } else {
            snackBarService.showSnackBar(
                message: 'Start time cannot be the same with End time',
                title: 'Warning');
            controller.text = '';
          }
        }
      } else {
        snackBarService.showSnackBar(
            message: 'Start time is empty', title: 'Warning');
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
    debugPrint(tempProcedure?.id);
    debugPrint(selectedProcedures[0].id);
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
