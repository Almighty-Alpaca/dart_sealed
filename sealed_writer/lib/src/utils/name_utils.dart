import 'package:sealed_writer/src/exceptions/exceptions.dart';

/// utilities for type and variable names
///
/// should not start with "_".
extension NameUtils on String {
  /// should not start with "_".
  bool startsWithUpper() {
    check(isNotEmpty && trim() == this && !contains(' '));

    String first;
    if (startsWith('_')) {
      check(length >= 2);
      first = substring(0, 2);
    } else {
      first = substring(0, 1);
    }

    final upperFirst = first.toUpperCase();
    return first == upperFirst;
  }

  /// should not start with "_".
  bool startsWithLower() {
    check(isNotEmpty && trim() == this && !contains(' '));

    String first;
    if (startsWith('_')) {
      check(length >= 2);
      first = substring(0, 2);
    } else {
      first = substring(0, 1);
    }

    final lowerFirst = first.toLowerCase();
    return first == lowerFirst;
  }

  String toUpperStart() {
    check(isNotEmpty && trim() == this && !contains(' '));

    String prefix, first, rest;
    if (startsWith('_')) {
      check(length >= 2);
      prefix = '_';
      first = substring(0, 2);
      rest = substring(2);
    } else {
      prefix = '';
      first = substring(0, 1);
      rest = substring(1);
    }

    final firstUpper = first.toUpperCase();
    check(firstUpper != first);

    return prefix + firstUpper + rest;
  }

  String toLowerStart() {
    check(isNotEmpty && trim() == this && !contains(' '));

    String prefix, first, rest;
    if (startsWith('_')) {
      check(length >= 2);
      prefix = '_';
      first = substring(0, 2);
      rest = substring(2);
    } else {
      prefix = '';
      first = substring(0, 1);
      rest = substring(1);
    }

    final lowerFirst = first.toLowerCase();
    check(lowerFirst != first);

    return prefix + lowerFirst + rest;
  }
}
