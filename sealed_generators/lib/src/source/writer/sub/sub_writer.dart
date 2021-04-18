import 'package:meta/meta.dart';
import 'package:sealed_annotations/sealed_annotations.dart';
import 'package:sealed_generators/src/manifest/manifest.dart';
import 'package:sealed_generators/src/source/source.dart';
import 'package:sealed_generators/src/source/writer/base/base_utils_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_constructor_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_copy_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_equatable_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_field_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_to_string_writer.dart';
import 'package:sealed_generators/src/utils/string_utils.dart';

/// source writer
@sealed
@immutable
class SubWriter extends BaseUtilsWriter {
  SubWriter(Source source)
      : subCopyWriter = SubCopyWriter(source),
        subToStringWriter = SubToStringWriter(source),
        subFieldWriter = SubFieldWriter(source),
        subConstructorWriter = SubConstructorWriter(source),
        subEquatableWriter = SubEquatableWriter(source),
        super(source);

  @nonVirtual
  @visibleForTesting
  final SubCopyWriter subCopyWriter;

  @nonVirtual
  @visibleForTesting
  final SubToStringWriter subToStringWriter;

  @nonVirtual
  @visibleForTesting
  final SubFieldWriter subFieldWriter;

  @nonVirtual
  @visibleForTesting
  final SubConstructorWriter subConstructorWriter;

  @nonVirtual
  @visibleForTesting
  final SubEquatableWriter subEquatableWriter;

  /// has nullable fields
  @protected
  @nonVirtual
  @visibleForTesting
  bool hasNullable(ManifestItem item) =>
      item.fields.map((field) => field.type).any((type) => type.isNullable);

  /// subclass start
  @protected
  @nonVirtual
  @visibleForTesting
  String subClassStart(ManifestItem item) => [
        'class ${subDec(item)} extends $topCall',
        if (options.equality == Equality.data) ' with EquatableMixin',
      ].joinParts();

  /// bool operator ==(Object other) => false;
  @nonVirtual
  @visibleForTesting
  String subDistinctEquality() => [
        annotationOverride,
        'bool$nn operator ==(Object other) => false;',
      ].joinLines();

  /// subclass
  @protected
  @nonVirtual
  @visibleForTesting
  String subClass(ManifestItem item) => [
        subClassStart(item),
        '{',
        subConstructorWriter.subConstructorDeclaration(item),
        subFieldWriter.subFieldDeclarations(item),
        if (!hasNullable(item) && !isGeneric)
          subCopyWriter.subCopyDeclaration(item),
        subToStringWriter.subToString(item),
        if (options.equality == Equality.data)
          subEquatableWriter.subEquatableEquality(item),
        if (options.equality == Equality.distinct) subDistinctEquality(),
        '}',
      ].joinMethods();

  @nonVirtual
  Iterable<String> subClasses() => manifest.items.map(subClass);
}
