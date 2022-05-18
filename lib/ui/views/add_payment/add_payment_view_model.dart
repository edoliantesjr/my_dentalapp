import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/models/dental_notes/dental_notes.dart';
import 'package:dentalapp/ui/widgets/select_payment_type/select_payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../models/user_model/user_model.dart';
import '../../widgets/selection_date/selection_date.dart';

class AddPaymentViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();

  final dentistTxtController = TextEditingController();
  final paymentTypeTxtController = TextEditingController();
  final dateTxtController = TextEditingController();
  final bottomSheetService = locator<BottomSheetService>();

  String selectedPaymentType = "";
  DateTime? selectedPaymentDate;
  List<DentalNotes>? selectedDentalNote = [];

  @override
  void dispose() {
    dentistTxtController.dispose();
    super.dispose();
  }

  Future<void> getAllPatientDentalNotes() async {}

  void showSelectDentist() async {
    UserModel? selectedDentist =
        await navigationService.pushNamed(Routes.SelectionDentist);
    if (selectedDentist != null) {
      dentistTxtController.text = selectedDentist.fullName;
    }
  }

  void showSelectPaymentType() async {
    selectedPaymentType = await Get.dialog(SelectPaymentType());
    paymentTypeTxtController.text = selectedPaymentType;
  }

  void selectDate() async {
    final DateTime date =
        await bottomSheetService.openBottomSheet(SelectionDate(
      title: 'Set date',
      initialDate: DateTime.now(),
      maxDate: DateTime.now(),
    ));
    if (date != null) {
      selectedPaymentDate = date;
      notifyListeners();
      dateTxtController.text = DateFormat.yMMMd().format(selectedPaymentDate!);
    }
  }

  void selectDentalNote(String patientId) async {
    navigationService.pushNamed(Routes.SelectDentalNoteView,
        arguments: SelectDentalNoteViewArguments(patientId: patientId));
  }
}
