import 'package:sealed_annotations/sealed_annotations.dart';

part 'result.g.dart';

@Sealed()
abstract class _Result<D extends num> {
  void success(D data);

  void error(Object exception);
}
