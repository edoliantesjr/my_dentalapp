import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/models/tooth_condition/tooth_condition.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SetToothConditionViewModel extends BaseViewModel {
  final toothConditionTextController = TextEditingController();
  final setToothConditionFormKey = GlobalKey<FormState>();

  final validatorService = locator<ValidatorService>();
  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  final dialogService = locator<DialogService>();
  final toastService = locator<ToastService>();

  @override
  void dispose() {
    toothConditionTextController.dispose();
    super.dispose();
  }

  void goToSelectToothCondition() async {
    toothConditionTextController.text =
        await navigationService.pushNamed(Routes.SelectionToothCondition) ?? '';
  }

  Future<void> addToothCondition({
    required String patientId,
    required List<String> selectedTeeth,
  }) async {
    dialogService.showDefaultLoadingDialog(
        barrierDismissible: false, willPop: false);
    for (String tooth in selectedTeeth) {
      debugPrint('adding ${tooth}');
      await apiService.addToothCondition(
          toothId: tooth,
          patientId: patientId,
          toothCondition: ToothCondition(
              selectedTooth: tooth,
              toothCondition: toothConditionTextController.text,
              date: DateTime.now().toString()));
    }
    navigationService.popRepeated(2);
    toastService.showToast(message: 'Successful: Set Tooth Condition!');
    debugPrint('Tooth Condition Added');
  }
}
