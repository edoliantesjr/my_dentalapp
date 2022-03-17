import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/models/user_model/user_model.dart';
import 'package:stacked/stacked.dart';

class SelectionDentistViewModel extends BaseViewModel {
//  Todo: logic code for selection dentist
  final apiService = locator<ApiService>();
  final navigationService = locator<NavigationService>();

  List<UserModel> dentistList = [];
  StreamSubscription? dentistStreamSub;

  @override
  void dispose() {
    dentistStreamSub?.cancel();
    super.dispose();
  }

  Future<void> searchDentist(String query) async {
    setBusy(true);
    dentistList = await apiService.searchDentist(query: query);
    notifyListeners();
    setBusy(false);
  }

  setReturnDentist(UserModel user) {
    navigationService.pop(returnValue: user);
  }
}
