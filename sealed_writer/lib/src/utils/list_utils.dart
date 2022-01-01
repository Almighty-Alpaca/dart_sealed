/// utilities for lists
extension ListUtils<T extends Object?> on List<T> {
  /// check has one element.
  bool get isSingle => length == 1;

  /// check has one or zero element.
  bool get isSingleOrEmpty => length == 0 || length == 1;

  /// first element or null if empty.
  T? get firstOrNull => length == 0 ? null : this[0];
}

// Taken from quiver
Iterable<T> concat<T>(Iterable<Iterable<T>> iterables) =>
    iterables.expand((x) => x);

// Adapted from quiver
extension IterableZip<T> on Iterable<Iterable<T>> {
  Iterable<List<T>> zip() sync* {
    if (isEmpty) return;
    final iterators = map((e) => e.iterator).toList(growable: false);
    while (iterators.every((e) => e.moveNext())) {
      yield iterators.map((e) => e.current).toList(growable: false);
    }
  }
}
