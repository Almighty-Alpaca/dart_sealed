import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:sealed_generators/src/manifest/annotation_utils.dart';
import 'package:sealed_writer/sealed_writer.dart';

/// manifest reader built by manifest reader builder
class ManifestReader {
  ManifestReader({
    required this.topName,
    required this.topEquality,
    required this.topPrefix,
    required this.topClass,
    required this.blocName,
  }) {
    check(topName.isGenClassName());
    check(topPrefix.isEmpty || topPrefix.isGenClassName());
  }

  /// top class name, like: Weather.
  final String topName;

  /// default equality.
  final ManifestEquality topEquality;

  /// default prefix.
  final String topPrefix;

  /// checked class element for manifest
  final ClassElement topClass;

  final String? blocName;

  /// read manifest
  Manifest read() {
    final params = _extractParams();
    final commonFields = _extractCommonFields();
    final items = _extractItems();
    final correctedItems = _correctItemsWithCommons(items, commonFields);

    return Manifest(
      name: topName,
      params: params,
      items: correctedItems,
      fields: commonFields,
      blocName: blocName,
    );
  }

  /// extract  class param
  ManifestParam _extractParam(TypeParameterElement p) {
    final bound = p.bound;
    return ManifestParam(
      name: p.name,
      bound: bound != null ? _extractManifestType(bound) : _defaultUpperBound(),
    );
  }

  /// extract class params
  List<ManifestParam> _extractParams() =>
      topClass.typeParameters.map(_extractParam).toList();

  /// extract sub class name, like 'rainy'
  String _extractSubShortName(MethodElement method) {
    final name = method.name;
    require(
      name.isGenTypeName(),
      () => "method name '$name' should be a valid type name",
    );
    require(
      name.startsWithLower(),
      () => "method name '$name' should start with lower case letter",
    );
    return name;
  }

  /// extract field name from method argument
  String _extractFieldName(ParameterElement arg) {
    final name = arg.name;
    require(
      name.isGenTypeName(),
      () => "method argument name '$name' should be valid type name",
    );
    require(
      name.isPublic(),
      () => "method argument name '$name' should not start with '_'",
    );
    require(
      name.startsWithLower(),
      () => "method argument name '$name' should start with lower case",
    );
    return name;
  }

  /// extract field from method argument without overrides
  ManifestField _extractField(ParameterElement arg) {
    final name = _extractFieldName(arg);
    return ManifestField(
      name: name,
      type: _readOverriddenTypeOrNull(arg) ?? _extractManifestType(arg.type),
      defaultValueCode: arg.defaultValueCode,
    );
  }

  /// extract fields from method
  List<ManifestField> _extractFields(MethodElement method) =>
      method.parameters.map(_extractField).toList();

  /// extract item from method
  ManifestItem _extractItem(MethodElement method) {
    require(
      method.typeParameters.isEmpty,
      () => "method '${method.name}' can not have type parameters",
    );
    return ManifestItem(
      shortName: _extractSubShortName(method),
      name: _extractSubFullName(method, _extractSubShortName(method)),
      equality: _extractSubEquality(method),
      fields: _extractFields(method),
    );
  }

  /// extract sub class full equality accounting overridden equality
  ManifestEquality _extractSubEquality(MethodElement method) =>
      extractWithEqualityOrNull(method) ?? topEquality;

  /// extract sub class full name accounting overridden name
  String _extractSubFullName(MethodElement method, String lower) =>
      extractWithNameOrNull(method) ?? _defaultFullName(lower);

  /// default full name of a sub class,
  /// like WeatherRainy.
  String _defaultFullName(String shortName) {
    if (shortName.startsWith('_')) {
      return '_$topPrefix${shortName.substring(1).toUpperStart()}';
    } else {
      return '$topPrefix${shortName.toUpperStart()}';
    }
  }

  /// extract items from class element
  List<ManifestItem> _extractItems() {
    final items = topClass.methods.map(_extractItem).toList();
    require(
      items.isNotEmpty,
      'sealed classes should have at least one item',
    );
    return items;
  }

  /// type name without any nullability sign
  String _extractTypeName(DartType type) {
    final typeName = type.getDisplayString(withNullability: false);
    final reference = type.element2;
    if (reference != null && isAnnotatedBySealed(reference)) {
      // type itself is a sealed manifest class
      require(
        typeName.startsWith('_') && typeName.length > 1,
        () => "referenced sealed class field type "
            "'$typeName' should start with '_'",
      );
      return typeName.substring(1);
    } else {
      return typeName;
    }
  }

  /// type is nullable?
  bool _extractTypeIsNullable(DartType type) =>
      type.nullabilitySuffix != NullabilitySuffix.none;

  /// extract manifest type
  ManifestType _extractManifestType(DartType type) => ManifestType(
        name: _extractTypeName(type),
        isNullable: _extractTypeIsNullable(type),
      );

  /// default upper bound
  ///
  /// all no bound types are considered nullable
  ManifestType _defaultUpperBound() => ManifestType(
        name: 'Object',
        isNullable: true,
      );

  /// read overridden type for an argument or null
  ManifestType? _readOverriddenTypeOrNull(Element element) =>
      extractWithTypeOrNull(element)?.readType();

  /// extract common fields from getters
  List<ManifestField> _extractCommonFields() =>
      topClass.fields.map(_extractCommonField).toList();

  /// extract common field from a getter
  ManifestField _extractCommonField(FieldElement field) {
    final name = _extractCommonFieldName(field);
    final library = field.session?.getParsedLibraryByElement(field.library)
        as ParsedLibraryResult;
    final node = library.getElementDeclaration(field)?.node;

    String? defaultValueCode;

    if (node is VariableDeclaration) {
      var initializer = node.initializer;
      if (initializer != null) {
        defaultValueCode = initializer.toString();
      }
    }

    return ManifestField(
      name: name,
      type: _readOverriddenCommonFieldTypeOrNull(field) ??
          _extractManifestType(field.type),
      defaultValueCode: defaultValueCode,
    );
  }

  /// read overridden common field type or null
  ///
  /// getter may be synthesized from a field
  ManifestType? _readOverriddenCommonFieldTypeOrNull(
    FieldElement field,
  ) =>
      field.isSynthetic
          ? _readOverriddenTypeOrNull(field.nonSynthetic)
          : _readOverriddenTypeOrNull(field);

  /// extract field name from method argument
  String _extractCommonFieldName(FieldElement field) {
    final name = field.name;
    require(
      name.isGenTypeName(),
      () => "getter/field name '$name' should be valid type name",
    );
    require(
      name.isPublic(),
      () => "getter/field name '$name' should not start with '_'",
    );
    require(
      name.startsWithLower(),
      () => "getter/field name '$name' should start with lower case",
    );
    return name;
  }

  /// add common fields to items
  List<ManifestItem> _correctItemsWithCommons(
    List<ManifestItem> items,
    List<ManifestField> commonFields,
  ) =>
      items
          .map((item) => ManifestItem(
                name: item.name,
                shortName: item.shortName,
                equality: item.equality,
                fields: _correctFieldsWithCommons(
                  item.fields,
                  commonFields,
                ).toList(),
              ))
          .toList();

  /// add common fields to fields
  Iterable<ManifestField> _correctFieldsWithCommons(
    List<ManifestField> fields,
    List<ManifestField> commonFields,
  ) sync* {
    final names = fields.map((e) => e.name).toList();
    for (final commonField in commonFields) {
      if (!names.contains(commonField.name)) {
        yield commonField;
      }
    }
    yield* fields;
  }
}
