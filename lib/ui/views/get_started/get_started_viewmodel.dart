import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/app/app.logger.dart';
import 'package:dentalapp/app/app.router.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/core/service/session_service/session_service.dart';
import 'package:dentalapp/models/get_started_model/get_started_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class GetStartedViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();
  final log = getLogger('GetStartedViewModel');
  final sessionService = locator<SessionService>();
  final pageController = PageController();

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
    if (index <= 1) {
      pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
      index++;
      notifyListeners();
    } else {
      log.i('root route is now login');
      sessionService.saveSession(
          isRunFirstTime: false, isLoggedIn: false, isAccountSetupDone: false);
      navigationService.pushReplacementNamed(Routes.Login);
    }
  }
}
