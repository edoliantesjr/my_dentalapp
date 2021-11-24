import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/models/get_started_model/get_started_model.dart';
import 'package:stacked/stacked.dart';

class GetStartedViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final log = getLogger('GetStartedViewModel');
  final sessionService = locator<SessionService>();

  int index = 0;
  List<GetStartedModel> listOfDetails = [
    GetStartedModel(
      title: 'Easy Appointment',
      image: 'assets/images/appointment.png',
      description:
          "Cagape Dental App let's you set appointments fast and easy!",
    ),
    GetStartedModel(
      title: 'Track Records',
      image: 'assets/images/appointment.png',
      description:
          "Records and Transactions are well organized and is saved to the cloud!",
    ),
    GetStartedModel(
      title: 'Sales Management',
      image: 'assets/images/appointment.png',
      description:
          "Cagape Dental App Let's you manage the clinic's sales and reports!",
    ),
  ];
  void indexChange(index) {
    this.index = index;
    notifyListeners();
  }

  void goToLoginView() {
    log.d('root route is now login');
    sessionService.saveSession(isRunFirstTime: false, isLoggedIn: false);
    navigationService.pushReplacementNamed(Routes.Login);
  }
}
