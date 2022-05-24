import 'dart:async';

import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/api/api_service.dart';
import 'package:dentalapp/core/service/connectivity/connectivity_service.dart';
import 'package:dentalapp/core/service/firebase_auth/firebase_auth_service.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/core/service/snack_bar/snack_bar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:stacked/stacked.dart';

class PreLoaderViewModel extends BaseViewModel {
  final sessionService = locator<SessionService>();
  final navigationService = locator<NavigationService>();
  final connectivityService = locator<ConnectivityService>();
  final snackBarService = locator<SnackBarService>();
  final firebaseAuthService = locator<FirebaseAuthService>();
  final apiService = locator<ApiService>();
  bool hasConnection = false;
  StreamSubscription? connectivitySub;

  // Future<dynamic> checkInternet() async {
  //   hasConnection = await connectivityService.checkConnectivity();
  //   notifyListeners();
  //   if (hasConnection) {
  //     getSessionInfo();
  //   } else {
  //     snackBarService.showSnackBar(
  //         message: 'No Internet Connection, Retrying...');
  //     return this;
  //   }
  // }

  void listenToConnectivityChanges() {
    connectivitySub =
        InternetConnectionChecker().onStatusChange.listen((event) async {
      if (event == InternetConnectionStatus.connected) {
        await getSessionInfo();
      } else {
        snackBarService.showSnackBar(
            message: 'No Internet Connection, Retrying...');
      }
    });
  }

  @override
  void dispose() {
    connectivitySub?.cancel();
    super.dispose();
  }

  Future<void> getSessionInfo() async {
    final sessionInfo = await sessionService.getSession();

    await Future.delayed(Duration(seconds: 1));
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
      final reLoginSuccess = await firebaseAuthService.reLoad();

      if (reLoginSuccess) {
        final uid = await FirebaseAuth.instance.currentUser!.uid;
        final patient = await apiService.getPatientInfo(patientId: uid);
        navigationService.popAllAndPushNamed(Routes.PatientInfoView,
            arguments: PatientInfoViewArguments(patient: patient));
      } else {
        snackBarService.showSnackBar(
            message: 'Login Error. Check Internet Connection. Try Again.',
            title: 'Error');
      }
    }
  }
}
