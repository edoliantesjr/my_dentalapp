import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

class SelectionListViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  String? selectedOption;

  final scrollController = FixedExtentScrollController(initialItem: 0);

  void setSelectedOption(List<String> options, int index) {
    selectedOption = options[index];
    notifyListeners();
  }

  void setReturnOption(List<String> options) {
    navigationService.pop(returnValue: selectedOption ?? options[0]);
  }
}
