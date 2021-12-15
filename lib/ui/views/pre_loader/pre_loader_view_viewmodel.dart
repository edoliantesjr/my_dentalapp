import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:stacked/stacked.dart';

class PreLoaderViewModel extends BaseViewModel {
  final sessionService = locator<SessionService>();
  final navigationService = locator<NavigationService>();

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
      navigationService.popAllAndPushNamed(Routes.MainBodyView);
    }
  }
}
