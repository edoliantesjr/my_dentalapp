import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  //convert date time to 12hr string format
  String toTime() => DateFormat.jm().format(this);

  String toStringDateFormat() => DateFormat.yMMMd().format(this);
}
