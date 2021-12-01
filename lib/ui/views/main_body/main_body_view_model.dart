import 'package:stacked/stacked.dart';

class MainBodyViewModel extends BaseViewModel {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
