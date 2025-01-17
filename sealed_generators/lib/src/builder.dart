import 'package:build/build.dart';
import 'package:sealed_generators/src/generator.dart';
import 'package:source_gen/source_gen.dart';

Builder sealedBuilder() {
  return SharedPartBuilder(
    const [SealedGenerator()],
    'sealed',
  );
}
