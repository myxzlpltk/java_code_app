import 'package:intl/intl.dart';

/// Ekstensi untuk format uang
extension CurrencyExtension on num {
  /// Static object untuk format uang
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  /// Format angka integer ke dalam format K
  /// 100000 => 100K
  /// 75500 => 75K
  String toShortK() => '${(this / 1000).floor()}K';

  /// Format angka integer ke dalam format rupiah
  /// 100000 => Rp. 100.000
  /// 75500 => Rp. 75.000
  String toRupiah() => _currencyFormat.format(this);
}
