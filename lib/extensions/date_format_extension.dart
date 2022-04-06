import 'package:dentalapp/extensions/string_extension.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  //convert date time to 12hr string format
  String toTime() => DateFormat.jm().format(this);

  String toStringDateFormat() => DateFormat.yMMMd().format(this);

  DateTime? toDateMonthDayOnly() =>
      DateFormat('yyyy-MM-dd').format(this).toDateTime();
}
