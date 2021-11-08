import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SetupUserViewModel extends FormViewModel {
  final navigationService = locator<NavigationService>();

  final dateOfBirth = TextEditingController();
  final setupFormKey = GlobalKey<FormState>();
  final validatorService = locator<ValidatorService>();
  @override
  void dispose() {
    dateOfBirth.dispose();
    super.dispose();
  }

  Future<void> selectDateOfBirth(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    if (selectedDate != null) {
      dateOfBirth.text = selectedDate.toString();
    }
  }

  @override
  void setFormStatus() {
    // TODO: implement setFormStatus
  }
}
