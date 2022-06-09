/// Ekstensi untuk melakukan format string
extension StringExtension on String {
  /// Format ke dalam kapital di huruf pertama
  /// judul umum => Judul umum
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  /// Format ke dalam judul kapital
  /// judul umum => Judul Umum
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  /// Format ke dalam bentuk rahasia
  /// Rahasia => *******
  String toObscure() => '*' * length;
}
