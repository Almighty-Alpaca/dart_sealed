// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_class.dart';

// **************************************************************************
// Generator: super_enum_sealed_generators
// **************************************************************************

// ignore_for_file: unused_element, unused_field

/// substitute generated manifest for super enum
/// and remove "$" at the end of class name.
@Sealed()
abstract class _Weather$ {
  @WithWrap()
  @WithEquality(Equality.data)
  @WithName('Sunny')
  void sunny();

  @WithWrap()
  @WithEquality(Equality.data)
  @WithName('Rainy')
  void rainy(Hello data);
}

/// [Weather] {
///
/// ([Sunny] sunny){} with data equality with wrap
///
/// ([Rainy] rainy){[Hello] data} with data equality with wrap
///
/// }
@immutable
@SealedManifest(_Weather)
abstract class Weather {
  const Weather._internal();

  @factory
  static Sunny sunny() => Sunny();

  @factory
  static Rainy rainy(
    Hello data,
  ) =>
      Rainy(
        data: data,
      );

  bool isSunny() => this is Sunny;

  bool isRainy() => this is Rainy;

  Sunny asSunny() => this as Sunny;

  Rainy asRainy() => this as Rainy;

  Sunny? asSunnyOrNull() {
    final weather = this;
    return weather is Sunny ? weather : null;
  }

  Rainy? asRainyOrNull() {
    final weather = this;
    return weather is Rainy ? weather : null;
  }

  R when<R extends Object?>({
    required R Function() sunny,
    required R Function(Hello data) rainy,
  }) {
    final weather = this;
    if (weather is Sunny) {
      return sunny();
    } else if (weather is Rainy) {
      return rainy(weather.data);
    } else {
      throw AssertionError();
    }
  }

  R whenOrElse<R extends Object?>({
    R Function()? sunny,
    R Function(Hello data)? rainy,
    required R Function(Weather weather) orElse,
  }) {
    final weather = this;
    if (weather is Sunny) {
      return sunny != null ? sunny() : orElse(weather);
    } else if (weather is Rainy) {
      return rainy != null ? rainy(weather.data) : orElse(weather);
    } else {
      throw AssertionError();
    }
  }

  R whenOrDefault<R extends Object?>({
    R Function()? sunny,
    R Function(Hello data)? rainy,
    required R orDefault,
  }) {
    final weather = this;
    if (weather is Sunny) {
      return sunny != null ? sunny() : orDefault;
    } else if (weather is Rainy) {
      return rainy != null ? rainy(weather.data) : orDefault;
    } else {
      throw AssertionError();
    }
  }

  R? whenOrNull<R extends Object?>({
    R Function()? sunny,
    R Function(Hello data)? rainy,
  }) {
    final weather = this;
    if (weather is Sunny) {
      return sunny?.call();
    } else if (weather is Rainy) {
      return rainy?.call(weather.data);
    } else {
      throw AssertionError();
    }
  }

  R whenOrThrow<R extends Object?>({
    R Function()? sunny,
    R Function(Hello data)? rainy,
  }) {
    final weather = this;
    if (weather is Sunny && sunny != null) {
      return sunny();
    } else if (weather is Rainy && rainy != null) {
      return rainy(weather.data);
    } else {
      throw AssertionError();
    }
  }

  void whenPartial({
    void Function()? sunny,
    void Function(Hello data)? rainy,
  }) {
    final weather = this;
    if (weather is Sunny) {
      sunny?.call();
    } else if (weather is Rainy) {
      rainy?.call(weather.data);
    } else {
      throw AssertionError();
    }
  }
}

/// (([Sunny] : [Weather]) sunny){}
///
/// with data equality
///
/// with wrap
@immutable
class Sunny extends Weather with EquatableMixin {
  const Sunny() : super._internal();

  @factory
  Sunny copy() => Sunny();

  @override
  String toString() => 'Weather.sunny()';

  @override
  List<Object?> get props => [];
}

/// (([Rainy] : [Weather]) rainy){[Hello] data}
///
/// with data equality
///
/// with wrap
@immutable
class Rainy extends Weather with EquatableMixin {
  const Rainy({
    required this.data,
  }) : super._internal();

  final Hello data;

  @factory
  Rainy copy({
    Hello? data,
  }) =>
      Rainy(
        data: data ?? this.data,
      );

  @override
  String toString() => 'Weather.rainy(data: $data)';

  @override
  List<Object?> get props => [
        data,
      ];
}