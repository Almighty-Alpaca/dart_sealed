import 'package:sealed_annotations/sealed_annotations.dart';

part 'result_common.g.dart';

@Sealed()
abstract class _Result<D extends num> {
  Object? get value;

  void success(D value);

  void error();
}
