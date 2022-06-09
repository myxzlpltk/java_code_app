import 'package:intl/intl.dart';

/// Ekstensi untuk format tanggal
extension DateExtension on DateTime {
  /// Static object untuk format tanggal dan tanggal waktu
  static final DateFormat _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  /// Ke dalam format tanggal
  String toDateString() => _dateFormat.format(this);

  /// Ke dalam format tanggal waktu
  String toDateTimeString() => _dateTimeFormat.format(this);
}
