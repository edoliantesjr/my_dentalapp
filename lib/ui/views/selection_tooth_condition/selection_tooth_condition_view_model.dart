import 'package:dentalapp/app/app.locator.dart';
import 'package:dentalapp/core/service/navigation/navigation_service.dart';
import 'package:dentalapp/enums/enum_tooth_condition.dart';
import 'package:stacked/stacked.dart';

class SelectionToothConditionViewModel extends BaseViewModel {
  List<String> toothConditionList = [];

  final navigationService = locator<NavigationService>();

  void getAllToothConditionName() {
    for (EnumToothCondition i in EnumToothCondition.values) {
      toothConditionList.add(i.name);
    }
    toothConditionList.sort();
  }

  void init() async {
    getAllToothConditionName();
  }

  void returnSelectedToothCondition(String condition) {
    navigationService.pop(returnValue: condition);
  }
}
