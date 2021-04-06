import 'package:sealed_generators/src/source/writer/top_cast.dart';
import 'package:sealed_generators/src/utils/string_utils.dart';
import 'package:test/test.dart';

import '../../../utils/code_utils.dart';
import '../../../utils/examples.dart';

void main() {
  group('class TopCastWriter', () {
    test('initialization', () {
      final source = source1DataSafe;
      final writer = TopCastWriter(source);

      expect(writer.source, source);
    });

    test('method topCastIs', () {
      final source = source1DataSafe;
      final item = source.manifest.items[0];
      final writer = TopCastWriter(source);

      expect(
        writer.topCastIs(item),
        'bool isSunny() => this is WeatherSunny;',
      );
    });

    test('method topCastsIs', () {
      final source = source1DataSafe;
      final writer = TopCastWriter(source);

      expect(
        writer.topCastsIs().joinMethods().tr(),
        stringContains([
          'isSunny()',
          'isRainy()',
          'isWindy()',
        ]),
      );
    });

    group('method topCastAs', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final item = source.manifest.items[0];
        final writer = TopCastWriter(source);

        expect(
          writer.topCastAs(item),
          'WeatherSunny asSunny() => this as WeatherSunny;',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final item = source.manifest.items[0];
        final writer = TopCastWriter(source);

        expect(
          writer.topCastAs(item),
          'WeatherSunny/*!*/ asSunny() => this as WeatherSunny/*!*/;',
        );
      });
    });

    test('method topCastsAs', () {
      final source = source1DataSafe;
      final writer = TopCastWriter(source);

      expect(
        writer.topCastsAs().joinMethods().tr(),
        stringContains([
          'asSunny()',
          'asRainy()',
          'asWindy()',
        ]),
      );
    });

    group('method topCastAsOrNull', () {
      test('null-safe', () {
        final source = source1DataSafe;
        final item = source.manifest.items[0];
        final writer = TopCastWriter(source);

        expect(
          writer.topCastAsOrNull(item).tr(),
          'WeatherSunny? asSunnyOrNull() {'
          'final weather = this;'
          'return weather is WeatherSunny ? weather : null;'
          '}',
        );
      });

      test('legacy', () {
        final source = source1DataLegacy;
        final item = source.manifest.items[0];
        final writer = TopCastWriter(source);

        expect(
          writer.topCastAsOrNull(item).tr(),
          'WeatherSunny/*?*/ asSunnyOrNull() {'
          'final weather = this;'
          'return weather is WeatherSunny/*!*/ ? weather : null;'
          '}',
        );
      });
    });

    test('method topCastsAsOrNull', () {
      final source = source1DataSafe;
      final writer = TopCastWriter(source);

      expect(
        writer.topCastsAsOrNull().joinMethods().tr(),
        stringContains([
          'asSunnyOrNull()',
          'asRainyOrNull()',
          'asWindyOrNull()',
        ]),
      );
    });

    test('method topCastMethods', () {
      final source = source1DataSafe;
      final writer = TopCastWriter(source);

      expect(
        writer.topCastMethods().joinMethods().tr(),
        stringContains([
          'isSunny()',
          'asRainy()',
          'asWindyOrNull()',
        ]),
      );
    });
    // end of group TopCastWriter
  });
}
