import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  static final DateFormat _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  String toDateString() => _dateFormat.format(this);

  String toDateTimeString() => _dateTimeFormat.format(this);
}
