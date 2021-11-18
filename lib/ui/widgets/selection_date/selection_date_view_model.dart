import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SelectionDateViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  String? selectedDate;

  void setSelectedDate(DateTime dateTime) {
    selectedDate = DateFormat.yMMMd().format(dateTime);
    notifyListeners();
  }

  void setReturnDate() {
    navigationService.pop(returnValue: selectedDate);
  }
}
