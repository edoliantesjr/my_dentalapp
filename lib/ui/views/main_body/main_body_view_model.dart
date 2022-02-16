import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class MainBodyViewModel extends BaseViewModel {
  int selectedIndex = 0;
  final navigationService = locator<NavigationService>();
  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
