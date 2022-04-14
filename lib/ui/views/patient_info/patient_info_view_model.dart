import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/url_launcher/url_launcher_service.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PatientInfoViewModel extends BaseViewModel {
  String age = '';
  ScrollController scrollController = ScrollController();
  final urlLauncher = locator<URLLauncherService>();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void computeAge({required String birthDate}) {
    age = AgeCalculator.age(birthDate.toDateTime()!, today: DateTime.now())
        .years
        .toString();
    notifyListeners();
  }

  void callPatient(String phone) {
    urlLauncher.callPhoneNumber(phone: phone);
  }

  void textPatient(String phone) {
    urlLauncher.sendTextMessage(phone: phone);
  }
}
