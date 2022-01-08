import 'package:sealed_writer/src/manifest/manifest.dart';
import 'package:sealed_writer/src/utils/string_utils.dart';
import 'package:sealed_writer/src/writer/base/base_utils_writer.dart';

/// source writer
class SubConstructorWriter extends BaseUtilsWriter {
  SubConstructorWriter(Manifest manifest) : super(manifest);

  /// ex. required this.velocity
  /// ex. required this.angle
  String subConstructorDecArg(ManifestField field) => [
        if (!field.type.isNullable && field.defaultValueCode == null) '$req ',
        'this.${field.name}',
        if (field.defaultValueCode != null) ' = ${field.defaultValueCode}'
      ].joinParts();

  /// ex. ({required this.velocity,})
  /// ex. ({this.angle,})
  String subConstructorDecArgs(ManifestItem item) => item.fields
      .map(subConstructorDecArg)
      .joinArgsFull()
      .withBracesOrNot()
      .withParenthesis();

  /// ex. required this.angle or @required this.angle
  String subConstructorWrappedDecArg(ManifestField field) =>
      'this.${field.name}';

  /// ex. ({required this.angle,})
  String subConstructorWrappedDecArgs(ManifestItem item) => item.fields
      .map(subConstructorWrappedDecArg)
      .joinArgsFull()
      .withParenthesis();

  /// ex. WeatherRainy({required this.rain, ...});
  String subConstructorDeclaration(ManifestItem item) => [
        'const ',
        subFull(item),
        subConstructorDecArgs(item),
        ': super._internal();',
      ].joinParts();
}
