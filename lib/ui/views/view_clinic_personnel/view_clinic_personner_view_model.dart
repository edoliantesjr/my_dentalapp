import 'dart:async';

import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/connectivity/connectivity_service.dart';
import 'package:dentalapp/core/service/dialog/dialog_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model/user_model.dart';

class ViewClinicPersonnelViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();
  final launcherService = locator<URLLauncherService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final apiService = locator<ApiService>();

  StreamSubscription? personnelStreamSub;
  List<UserModel> personnels = [];

  Future<void> getPersonnel() async {
    if (await connectivityService.checkConnectivity()) {
      final persnls = await apiService.getPersonnel();
      if (persnls != null) {
        personnels = persnls;
        notifyListeners();
      }
    } else {
      snackBarService.showSnackBar(
          message: 'No Network Connection', title: "Failed");
    }
  }

  @override
  void dispose() {
    personnelStreamSub?.cancel();
    super.dispose();
  }

  void init() async {
    setBusy(true);
    await getPersonnel();
    await Future.delayed(Duration(seconds: 1));
    setBusy(false);
    listenToUserModelChanges();
  }

  void listenToUserModelChanges() {
    apiService.listenToUserChanges().listen((event) {
      personnelStreamSub?.cancel();
      personnelStreamSub = apiService.listenToUserChanges().listen((event) {
        getPersonnel();
      });
    });
  }

  void call(String phone) {
    launcherService.callPhoneNumber(phone: phone);
  }

  void text(String phone) {
    launcherService.sendTextMessage(phone: phone);
  }
}
