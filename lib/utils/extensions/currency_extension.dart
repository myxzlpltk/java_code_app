import 'package:intl/intl.dart';

extension CurrencyExtension on num {
  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 0,
  );

  String toShortK() => '${(this / 1000).floor()}K';

  String toRupiah() => _currencyFormat.format(this);
}
