import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:stacked/stacked.dart';

class MainBodyViewModel extends BaseViewModel {
  int selectedIndex = 0;
  final navigationService = locator<NavigationService>();
  bool readyToPopUntilFirst = false;
  int oldIndex = 0;
  void setSelectedIndex(int index) {
    // if (selectedIndex == oldIndex) {
    // if (Get.routeTree.isBlank != null && Get.routeTree.isBlank == false) {
    //   Get.until((Route route) => route.isFirst, id: selectedIndex);
    // }
    // }
    selectedIndex = index;
    notifyListeners();
  }
}
