import 'package:stacked/stacked.dart';

class LandingPageViewModel extends BaseViewModel {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
