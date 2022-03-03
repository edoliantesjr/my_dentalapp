import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/procedure/procedure.dart';
import 'package:stacked/stacked.dart';

class SelectionProcedureViewModel extends BaseViewModel {
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<Procedure>? procedureList;
  StreamSubscription? procedureStreamSub;

  @override
  void dispose() {
    procedureStreamSub?.cancel();
    super.dispose();
  }

  void getListOfProcedure() async {
    setBusy(true);
    apiService.getProcedureList().listen((event) {
      procedureStreamSub?.cancel();
      procedureStreamSub = apiService.getProcedureList().listen((event) async {
        procedureList = await event;
        notifyListeners();
      });
    });
    await Future.delayed(Duration(milliseconds: 500));
    setBusy(false);
  }

  void returnProcedure({required Procedure procedure}) {
    navigationService.pop(returnValue: procedure);
  }
}
