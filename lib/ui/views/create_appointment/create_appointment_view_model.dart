import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/models/appointment_model/appoinment_model.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_time/selection_time.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class CreateAppointmentViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final bottomSheetService = locator<BottomSheetService>();
  final validatorService = locator<ValidatorService>();

  String? tempDate;
  List<Procedure> selectedProcedures = [];

  Future<void> setAppointment(AppointmentModel appointment) async {
    //TODO: Logic code for setting an appointment
    try {
      await apiService.createAppointment(appointment);
      toastService.showToast(message: 'Appointment added');
    } catch (e) {
      //todo: logic 4 catch error
    }
  }

  void selectDate(TextEditingController controller) async {
    String selectedDate =
        await bottomSheetService.openBottomSheet(SelectionDate(
              title: 'Set Appointment date',
              initialDate: DateTime.now(),
              maxDate: DateTime.utc(DateTime.now().year + 5),
            )) ??
            '';
    tempDate = selectedDate != '' ? selectedDate : tempDate ?? '';
    selectedDate = tempDate ?? selectedDate;
    controller.text = selectedDate;
    notifyListeners();
  }

  void selectStartTime(TextEditingController controller) async {
    //todo: code for setting start time
    String selectedStartTime =
        await bottomSheetService.openBottomSheet(SelectionTime(
              title: 'Set Start Time',
              initialDateTime: DateTime.now(),
            )) ??
            '';
  }

  void selectEndTime(TextEditingController controller) async {
    //todo: code for setting end time
    String selectedStartTime =
        await bottomSheetService.openBottomSheet(SelectionTime(
              title: 'Set Start Time',
              initialDateTime: DateTime.now(),
            )) ??
            '';
  }

  void openProcedureFullScreenModal(TextEditingController controller) async {
    final tempProcedure =
        await navigationService.pushNamed(Routes.SelectionProcedure);
    // await bottomSheetService.openFullScreenModal(SelectionProcedure());
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
    final tempProcedure =
        await navigationService.pushNamed(Routes.SelectionDentist);
    // final tempProcedure =
    //     await bottomSheetService.openFullScreenModal(SelectionDentist());
    // if (tempProcedure != null) {
    //   if (!(selectedProcedures
    //       .map((procedure) => procedure.id)
    //       .contains(tempProcedure.id))) {
    //     selectedProcedures.add(tempProcedure);
    //     notifyListeners();
    //   } else {
    //     toastService.showToast(message: 'Already Selected');
    //   }
    // }
  }

  void deleteSelectedProcedure(Procedure procedure) {
    selectedProcedures.removeWhere((element) => element.id == procedure.id);
    notifyListeners();
    toastService.showToast(message: 'Removed');
  }
}
