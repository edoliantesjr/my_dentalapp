import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/toast/toast_service.dart';
import 'package:dentalapp/core/service/validator/validator_service.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class AddProcedureViewModel extends BaseViewModel {
  //Todo: logic code for add procedure view
  final navigationService = locator<NavigationService>();
  final toastService = locator<ToastService>();
  final apiService = locator<ApiService>();
  final validatorService = locator<ValidatorService>();

  Future<void> addProcedure(
      {required String procedureName, String? price}) async {
    setBusy(true);
    try {
      await apiService.addProcedure(
          procedure: Procedure(
        procedureName: procedureName,
        price: price ?? '',
      ));
      setBusy(false);
      navigationService.pop();
      toastService.showToast(message: 'Procedure Added');
    } catch (e) {
      debugPrint(e.toString());
      setBusy(false);
    }
  }
}
