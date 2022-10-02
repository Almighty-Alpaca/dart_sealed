import 'package:analyzer/dart/element/element.dart';
import 'package:sealed_generators/src/manifest/annotation_utils.dart';
import 'package:sealed_generators/src/manifest/manifest_reader.dart';
import 'package:sealed_writer/sealed_writer.dart';
import 'package:source_gen/source_gen.dart';

/// provides options and details not general to the manifest to reader
class ManifestReaderBuilder {
  const ManifestReaderBuilder();

  /// build manifest reader
  ManifestReader build(Element element, ConstantReader annotation) {
    final topClass = _extractClassElement(element);
    final topName = _extractTopName(topClass);
    final topEquality = _extractTopEquality(element);
    final topPrefix = _extractTopPrefix(element, topName);
    final blocName = _extractBlocName(annotation);
    return ManifestReader(
      topName: topName,
      topEquality: topEquality,
      topPrefix: topPrefix,
      topClass: topClass,
      blocName: blocName,
    );
  }

  /// extract top prefix
  String _extractTopPrefix(Element element, String topName) =>
      extractWithPrefixOrNull(element) ?? topName;

  /// extract top equality
  ManifestEquality _extractTopEquality(Element element) =>
      extractWithEqualityOrNull(element) ?? ManifestEquality.data;

  /// extract class element
  ClassElement _extractClassElement(Element e) {
    require(
      e is ClassElement,
      'element should be a class',
    );
    final cls = e as ClassElement;
    require(
      cls is! EnumElement && cls is! MixinElement && !cls.isMixinApplication,
      'element should be a Class',
    );
    require(
      cls.isPrivate && cls.name.isPrivate(),
      'class should be private',
    );
    require(
      cls.allSupertypes.length == 1,
      'class should have only Object as super type',
    );
    return cls;
  }

  /// extract top class name
  String _extractTopName(ClassElement cls) {
    final name = cls.name;
    require(
      name.isGenTypeName() && name.isPrivate(),
      () => "class name '$name' should be a valid private type name",
    );
    final str = name.substring(1);
    require(
      str.startsWithUpper(),
      () => "class '$name' name should start with upper case letter",
    );
    return str;
  }

  String? _extractBlocName(ConstantReader annotation) {
    return annotation.peek('bloc')?.typeValue.element2?.name;
  }
}
