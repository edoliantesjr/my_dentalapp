import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/ui/widgets/select_payment_type/select_payment_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.router.dart';
import '../../../main.dart';
import '../../../models/user_model/user_model.dart';

class AddPaymentViewModel extends BaseViewModel {
  final validatorService = locator<ValidatorService>();

  final dentistTxtController = TextEditingController();
  final paymentTypeTxtController = TextEditingController();
  final dateTxtController = TextEditingController();
  String selectedPaymentType = "";

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
}
