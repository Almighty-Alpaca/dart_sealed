import 'package:sealed_annotations/sealed_annotations.dart';

part 'result_common_split.g.dart';

@Sealed()
abstract class _ResultLeftRight<D extends num> {
  D get data;

  void successLeft();

  void successRight();
}
