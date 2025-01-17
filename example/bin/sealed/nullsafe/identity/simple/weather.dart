import 'package:sealed_annotations/sealed_annotations.dart';

part 'weather.g.dart';

@Sealed()
@WithEquality(Equality.identity)
abstract class _Weather {
  void sunny();

  void rainy(int rain);

  void windy(double velocity, double? angle);
}
