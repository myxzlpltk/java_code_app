import 'dart:core';

/// Ekstensi untuk object Iterable
extension IndexedIterable<E> on Iterable<E> {
  /// Melakukan mapping dengan object dan indexnya
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
