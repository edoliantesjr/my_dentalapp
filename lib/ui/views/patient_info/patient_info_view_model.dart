import 'package:age_calculator/age_calculator.dart';
import 'package:dentalapp/extensions/string_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class PatientInfoViewModel extends BaseViewModel {
  String age = '';
  ScrollController scrollController = ScrollController();

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
}
