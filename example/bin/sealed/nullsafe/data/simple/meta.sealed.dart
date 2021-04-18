// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meta.dart';

// **************************************************************************
// Generator: sealed_generators
// **************************************************************************

/// Weather {
///
/// (WeatherSunny sunny){} with data equality
///
/// (WeatherRainy rainy){int rain} with data equality
///
/// (WeatherWindy windy){double velocity, double? angle} with data equality
///
/// }
@SealedManifest(_Weather)
abstract class Weather {
  @factory
  static WeatherSunny sunny() => WeatherSunny();

  @factory
  static WeatherRainy rainy({
    required int rain,
  }) =>
      WeatherRainy(
        rain: rain,
      );

  @factory
  static WeatherWindy windy({
    required double velocity,
    required double? angle,
  }) =>
      WeatherWindy(
        velocity: velocity,
        angle: angle,
      );

  bool isSunny() => this is WeatherSunny;

  bool isRainy() => this is WeatherRainy;

  bool isWindy() => this is WeatherWindy;

  WeatherSunny asSunny() => this as WeatherSunny;

  WeatherRainy asRainy() => this as WeatherRainy;

  WeatherWindy asWindy() => this as WeatherWindy;

  WeatherSunny? asSunnyOrNull() {
    final weather = this;
    return weather is WeatherSunny ? weather : null;
  }

  WeatherRainy? asRainyOrNull() {
    final weather = this;
    return weather is WeatherRainy ? weather : null;
  }

  WeatherWindy? asWindyOrNull() {
    final weather = this;
    return weather is WeatherWindy ? weather : null;
  }

  R when<R extends Object?>({
    required R Function(WeatherSunny sunny) sunny,
    required R Function(WeatherRainy rainy) rainy,
    required R Function(WeatherWindy windy) windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      return sunny(weather);
    } else if (weather is WeatherRainy) {
      return rainy(weather);
    } else if (weather is WeatherWindy) {
      return windy(weather);
    } else {
      throw AssertionError();
    }
  }

  R whenOrElse<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    required R Function(Weather weather) orElse,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      return (sunny ?? orElse)(weather);
    } else if (weather is WeatherRainy) {
      return (rainy ?? orElse)(weather);
    } else if (weather is WeatherWindy) {
      return (windy ?? orElse)(weather);
    } else {
      throw AssertionError();
    }
  }

  R whenOrDefault<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    required R orDefault,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      return sunny != null ? sunny(weather) : orDefault;
    } else if (weather is WeatherRainy) {
      return rainy != null ? rainy(weather) : orDefault;
    } else if (weather is WeatherWindy) {
      return windy != null ? windy(weather) : orDefault;
    } else {
      throw AssertionError();
    }
  }

  R? whenOrNull<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      return sunny?.call(weather);
    } else if (weather is WeatherRainy) {
      return rainy?.call(weather);
    } else if (weather is WeatherWindy) {
      return windy?.call(weather);
    } else {
      throw AssertionError();
    }
  }

  R whenOrThrow<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny && sunny != null) {
      return sunny(weather);
    } else if (weather is WeatherRainy && rainy != null) {
      return rainy(weather);
    } else if (weather is WeatherWindy && windy != null) {
      return windy(weather);
    } else {
      throw AssertionError();
    }
  }

  void branch({
    required void Function(WeatherSunny sunny) sunny,
    required void Function(WeatherRainy rainy) rainy,
    required void Function(WeatherWindy windy) windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      sunny(weather);
    } else if (weather is WeatherRainy) {
      rainy(weather);
    } else if (weather is WeatherWindy) {
      windy(weather);
    } else {
      throw AssertionError();
    }
  }

  void branchPartial({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      sunny?.call(weather);
    } else if (weather is WeatherRainy) {
      rainy?.call(weather);
    } else if (weather is WeatherWindy) {
      windy?.call(weather);
    } else {
      throw AssertionError();
    }
  }

  void branchOrElse({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
    required void Function(Weather weather) orElse,
  }) {
    final weather = this;
    if (weather is WeatherSunny) {
      (sunny ?? orElse)(weather);
    } else if (weather is WeatherRainy) {
      (rainy ?? orElse)(weather);
    } else if (weather is WeatherWindy) {
      (windy ?? orElse)(weather);
    } else {
      throw AssertionError();
    }
  }

  void branchOrThrow({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
  }) {
    final weather = this;
    if (weather is WeatherSunny && sunny != null) {
      sunny(weather);
    } else if (weather is WeatherRainy && rainy != null) {
      rainy(weather);
    } else if (weather is WeatherWindy && windy != null) {
      windy(weather);
    } else {
      throw AssertionError();
    }
  }
}

class WeatherSunny extends Weather with EquatableMixin {
  WeatherSunny();

  @factory
  WeatherSunny copy() => WeatherSunny();

  @override
  String toString() => 'Weather.Sunny()';

  @override
  List<Object?> get props => [];
}

class WeatherRainy extends Weather with EquatableMixin {
  WeatherRainy({
    required this.rain,
  });

  final int rain;

  @factory
  WeatherRainy copy({
    int? rain,
  }) =>
      WeatherRainy(
        rain: rain ?? this.rain,
      );

  @override
  String toString() => 'Weather.Rainy(rain: $rain)';

  @override
  List<Object?> get props => [
        rain,
      ];
}

class WeatherWindy extends Weather with EquatableMixin {
  WeatherWindy({
    required this.velocity,
    required this.angle,
  });

  final double velocity;
  final double? angle;

  @override
  String toString() => 'Weather.Windy(velocity: $velocity, angle: $angle)';

  @override
  List<Object?> get props => [
        velocity,
        angle,
      ];
}