import 'package:sealed_generators/src/source/source.dart';
import 'package:sealed_generators/src/source/writer/base_utils.dart';
import 'package:test/test.dart';

import '../../../utils/examples.dart';

class _Writer extends BaseUtilsWriter {
  const _Writer(Source source) : super(source);
}

void main() {
  group('class BaseWriter', () {
    test('initialization', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.source, source);
    });

    test('getter manifest', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.manifest, source.manifest);
    });

    test('getter options', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.options, source.options);
    });

    test('annotation closed', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.annotationClosed, '@sealed');
    });

    test('annotation immutable', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.annotationImmutable, '@immutable');
    });

    test('annotation factory', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.annotationFactory, '@factory');
    });

    test('annotation override', () {
      final source = source1DataSafe;
      final writer = _Writer(source);

      expect(writer.annotationOverride, '@override');
    });

    group('getter n', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = _Writer(source);

        expect(writer.n, '?');
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = _Writer(source);

        expect(writer.n, '/*?*/');
      });
    });

    group('getter nl', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = _Writer(source);

        expect(writer.nl, '');
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = _Writer(source);

        expect(writer.nl, '/*?*/');
      });
    });

    group('getter nn', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = _Writer(source);

        expect(writer.nn, '');
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = _Writer(source);

        expect(writer.nn, '/*!*/');
      });
    });

    group('getter req', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final writer = _Writer(source);

        expect(writer.req, 'required');
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final writer = _Writer(source);

        expect(writer.req, '@required');
      });
    });

    test('method top', () {
      final source = source1DataLegacy;
      final writer = _Writer(source);

      expect(writer.top, 'Weather');
    });

    test('method topLower', () {
      final source = source1DataLegacy;
      final writer = _Writer(source);

      expect(writer.topLower, 'weather');
    });

    test('method short', () {
      final source = source1DataSafe;
      final item = source.manifest.items[0];
      final writer = _Writer(source);

      expect(writer.subShort(item), 'Sunny');
    });

    test('method full', () {
      final source = source1DataSafe;
      final item = source.manifest.items[0];
      final writer = _Writer(source);

      expect(writer.subFull(item), 'WeatherSunny');
    });

    test('method lower', () {
      final source = source1DataSafe;
      final item = source.manifest.items[0];
      final writer = _Writer(source);

      expect(writer.subLower(item), 'sunny');
    });

    group('method typeSL', () {
      group('null-safe', () {
        final source = source1DataSafe;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final type1 = field1.type;
        final field2 = item.fields[1];
        final type2 = field2.type;
        final writer = _Writer(source);

        test('non-nullable type', () {
          expect(writer.typeSL(type1), 'double');
        });

        test('nullable type', () {
          expect(writer.typeSL(type2), 'double?');
        });
      });

      group('legacy', () {
        final source = source1DataLegacy;
        // void windy(double velocity, double? angle);
        final item = source.manifest.items[2];
        final field1 = item.fields[0];
        final type1 = field1.type;
        final field2 = item.fields[1];
        final type2 = field2.type;
        final writer = _Writer(source);

        test('non-nullable type', () {
          expect(writer.typeSL(type1), 'double/*!*/');
        });

        test('nullable type', () {
          expect(writer.typeSL(type2), 'double/*?*/');
        });
      });
    });

    test('method initThisValue', () {
      final source = source1DataLegacy;
      final writer = _Writer(source);

      expect(
        writer.initThisValue(),
        'final weather = this;',
      );
    });
    // end of group BaseUtilsWriter
  });
}
