import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/bottom_sheet/bottom_sheet_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/ui/widgets/selection_date/selection_date.dart';
import 'package:dentalapp/ui/widgets/selection_list/selection_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SetupUserViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final validatorService = locator<ValidatorService>();
  final bottomSheetService = locator<BottomSheetService>();

  final setupFormKey = GlobalKey<FormState>();

  final List<String> genderOptions = ['Male', 'Female'];
  final List<String> positionOptions = ['Admin/Doctor', 'Staff'];

  Future<void> setGenderValue(
      TextEditingController textEditingController) async {
    textEditingController.text =
        await bottomSheetService.openBottomSheet(SelectionList(
      options: genderOptions,
    ));
    notifyListeners();
  }

  Future<void> setPositionValue(
      TextEditingController textEditingController) async {
    textEditingController.text =
        await bottomSheetService.openBottomSheet(SelectionList(
      options: positionOptions,
    ));
    notifyListeners();
  }

  Future<void> setBirthDateValue(
      TextEditingController textEditingController) async {
    textEditingController.text =
        await bottomSheetService.openBottomSheet(SelectionDate());
    notifyListeners();
  }
}
