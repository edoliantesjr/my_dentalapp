import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class SelectionDateViewModel extends BaseViewModel {
  final navigationService = locator<NavigationService>();

  String? selectedDate;
  final dateTimeNow = DateTime.now();
  final defaultStartDate = DateTime.utc(2000);

  void setSelectedDate(DateTime dateTime) {
    selectedDate = DateFormat.yMMMd().format(dateTime);
    notifyListeners();
  }

  void setReturnDate({DateTime? initialDate}) {
    dynamic defaultSelectedDate =
        DateFormat.yMMMd().format(initialDate ?? defaultStartDate);
    navigationService.pop(
        returnValue: selectedDate ?? defaultSelectedDate ?? '');
  }
}
