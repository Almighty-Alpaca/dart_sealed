import 'package:sealed_annotations/sealed_annotations.dart';

part 'meta.g.dart';

@Sealed()
@WithPrefix('Prefix')
abstract class _Weather {
  void sunny();

  @WithName('BadWeather')
  void rainy(int rain);

  @WithName('VeryBadWeather')
  @WithEquality(Equality.distinct)
  void windy(double velocity, double? angle);
}

@Sealed()
@WithPrefix('')
abstract class _ApiError {
  void internetError();

  void serverError(int code);

  void otherError(String? message);
}
