import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/connectivity/connectivity_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:stacked/stacked.dart';

class PreLoaderViewModel extends BaseViewModel {
  final sessionService = locator<SessionService>();
  final navigationService = locator<NavigationService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  bool hasConnection = false;

  Future<void> checkInternet() async {
    hasConnection = await connectivityService.checkConnectivity();
    notifyListeners();
    if (hasConnection) {
      getSessionInfo();
    } else {
      snackBarService.showSnackBar(
          message: 'No Internet Connection, Retrying...');
    }
  }

  Future<void> getSessionInfo() async {
    final sessionInfo = await sessionService.getSession();

    await Future.delayed(Duration(seconds: 3));
    if (hasConnection) {
      if (sessionInfo.isRunFirstTime) {
        navigationService.popAllAndPushNamed(Routes.GetStarted);
      } else if (!sessionInfo.isRunFirstTime && !sessionInfo.isLoggedIn) {
        navigationService.popAllAndPushNamed(Routes.Login);
      } else if (!sessionInfo.isRunFirstTime &&
          sessionInfo.isLoggedIn &&
          !sessionInfo.isAccountSetupDone) {
        navigationService.popAllAndPushNamed(Routes.Login);
      } else if (!sessionInfo.isRunFirstTime &&
          sessionInfo.isLoggedIn &&
          sessionInfo.isAccountSetupDone) {
        navigationService.popAllAndPushNamed(Routes.MainBodyView);
      }
    } else {
      checkInternet();
    }
  }
}
