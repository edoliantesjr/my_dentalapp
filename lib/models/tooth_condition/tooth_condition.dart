import 'package:dentalapp/enums/enum_tooth_condition.dart';

class ToothCondition {
  final dynamic id;
  final List<dynamic> toothConditions;
  final String date;
  final String selectedTooth;

  const ToothCondition({
    this.id,
    required this.selectedTooth,
    required this.toothConditions,
    required this.date,
  });

  Map<String, dynamic> toJson({required id}) {
    return {
      'id': id,
      'selectedTooth': this.selectedTooth,
      'toothConditions': this.toothConditions,
      'date': this.date,
    };
  }

  factory ToothCondition.fromJson(Map<String, dynamic> map) {
    return ToothCondition(
      id: map['id'] as dynamic,
      toothConditions: map['toothConditions'] as List<EnumToothCondition>,
      date: map['date'] as String,
      selectedTooth: map['selectedTooth'] as String,
    );
  }
}
