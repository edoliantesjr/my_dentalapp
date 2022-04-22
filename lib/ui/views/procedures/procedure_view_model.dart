import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:stacked/stacked.dart';

class ProcedureViewModel extends BaseViewModel {

  final navigationService = locator<NavigationService>();
  final apiService = locator<ApiService>();
  StreamSubscription? procedureStreamSub;
  List<Procedure> procedureList = [];
  bool isScrolledUp = true;

  void setFabSize({required bool isScrolledUp}) {
    this.isScrolledUp = isScrolledUp;
    notifyListeners();
  }

  void getProcedureList() {
    apiService.getProcedureList().listen((event) {
      procedureStreamSub?.cancel();
      procedureStreamSub = apiService.getProcedureList().listen((procedures) {
        procedureList = procedures;
        notifyListeners();
      });
    });
  }

  void deleteProcedure() {
    //  Todo: logic code to delete procedure
  }
}
