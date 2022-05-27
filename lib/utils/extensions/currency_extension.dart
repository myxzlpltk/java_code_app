extension CurrencyExtension on num {
  String toShortK() => '${(this / 1000).floor()}K';
}