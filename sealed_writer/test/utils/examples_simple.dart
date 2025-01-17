part of 'examples.dart';

Manifest manifest1([ManifestEquality equality = ManifestEquality.data]) =>
    Manifest(
      name: 'Weather',
      items: [
        ManifestItem(
          shortName: 'sunny',
          name: 'HiSunny',
          equality: equality,
          fields: [],
        ),
        ManifestItem(
          shortName: 'rainy',
          name: 'WeatherRainy',
          equality: equality,
          fields: [
            ManifestField(
              name: 'rain',
              type: ManifestType(name: 'int', isNullable: false),
              defaultValueCode: null,
            ),
          ],
        ),
        ManifestItem(
          shortName: 'windy',
          name: 'HelloWindy',
          equality: equality,
          fields: [
            ManifestField(
              name: 'velocity',
              type: ManifestType(name: 'double', isNullable: false),
              defaultValueCode: null,
            ),
            ManifestField(
              name: 'angle',
              type: ManifestType(name: 'double', isNullable: true),
              defaultValueCode: null,
            )
          ],
        ),
      ],
      params: [],
      fields: [],
    );

final manifest1Data = manifest1(ManifestEquality.data);
final manifest1Identity = manifest1(ManifestEquality.identity);
final manifest1Distinct = manifest1(ManifestEquality.distinct);

final code1Data = code1(ManifestEquality.data);
final code1Identity = code1(ManifestEquality.identity);
final code1Distinct = code1(ManifestEquality.distinct);

String code1(ManifestEquality equality) => '''@Sealed()
abstract class _Weather
{
@WithEquality(${_equality(equality)})
@WithName('HiSunny')
void sunny();

@WithEquality(${_equality(equality)})
@WithName('WeatherRainy')
void rainy(int rain);

@WithEquality(${_equality(equality)})
@WithName('HelloWindy')
void windy(double velocity, double? angle);
}''';

final doc1Data = doc1('data');
final doc1Identity = doc1('identity');
final doc1Distinct = doc1('distinct');

String doc1(String equality) => '''/// [Weather] {
/// 
/// ([HiSunny] sunny){} with $equality equality
/// 
/// ([WeatherRainy] rainy){[int] rain} with $equality equality
/// 
/// ([HelloWindy] windy){[double] velocity, [double]? angle} with $equality equality
/// 
/// }''';
