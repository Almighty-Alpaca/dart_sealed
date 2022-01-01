import 'package:sealed_writer/src/manifest/manifest.dart';
import 'package:sealed_writer/src/utils/list_utils.dart';
import 'package:sealed_writer/src/utils/string_utils.dart';
import 'package:sealed_writer/src/writer/base/base_utils_writer.dart';

/// source writer
class BlocWriter extends BaseUtilsWriter {
  BlocWriter(Manifest manifest) : super(manifest);

  Iterable<String> blocClasses() {
    if (manifest.blocName == null) {
      return [];
    } else {
      return <String>[
        blocTypedefs(),
        blocClass(),
        blocBuilderFunction(),
      ];
    }
  }

  String blocTypedefs() =>
      manifest.items.map((e) => blocTypedef(e)).joinLines();

  String blocTypedef(ManifestItem e) => <String>[
        'typedef',
        blocTypedefName(e),
        '=',
        'Widget',
        'Function(',
        <String>[
          blocBuilderContextParameter(),
          ...blocBuilderParameters(e),
        ].joinArgsFull(),
        ');'
      ].joinDeclaration();

  String blocTypedefName(ManifestItem item) => '${item.name}Builder';

  String blocBuilderContextParameter() {
    return [
      'BuildContext',
      'context',
    ].joinDeclaration();
  }

  Iterable<String> blocBuilderParameters(ManifestItem item) {
    return <Iterable<String>>[
      blocBuilderParameterTypes(item),
      blocBuilderParameterNames(item),
    ].zip().map((e) => e.joinDeclaration());
  }

  Iterable<String> blocBuilderParameterNames(ManifestItem item) =>
      item.fields.map((e) => e.name);

  Iterable<String> blocBuilderParameterTypes(ManifestItem item) =>
      item.fields.map((e) => typeSL(e.type));

  String blocClass() {
    return <String>[
      blocClassStart(),
      '{',
      blocClassConstructor(),
      '}',
    ].joinLines();
  }

  String blocClassStart() {
    return <String>[
      'class',
      blocClassName(),
      'extends',
      'BlocBuilder<${manifest.blocName}, ${manifest.name}>',
    ].joinDeclaration();
  }

  String blocClassName() =>
      '${manifest.blocName!.replaceAll(RegExp('(Bloc|Cubit)'), '')}BlocBuilder';

  String blocClassConstructor() {
    return <String>[
      blocClassName(),
      '({',
      <String>[
        blocClassConstructorKeyParameter(),
        ...blocClassConstructorBuilderParameters(),
        ...blocClassConstructorBlocParameters(),
      ].joinArgsFull(),
      '})',
      ':',
      'super(',
      <String>[
        blocClassConstructorSuperKeyParameter(),
        blocClassConstructorSuperBuilderParameter(),
        ...blocClassConstructorSuperBlocParameters(),
      ].joinArgsFull(),
      ');'
    ].join();
  }

  String blocClassConstructorKeyParameter() => [
        'Key?',
        'key',
      ].joinDeclaration();

  Iterable<String> blocClassConstructorBuilderParameters() {
    return manifest.items.map((e) => blocClassConstructorBuilderParameter(e));
  }

  String blocClassConstructorBuilderParameter(ManifestItem item) => [
        'required',
        blocTypedefName(item),
        blocClassConstructorBuilderParameterName(item),
      ].joinDeclaration();

  String blocClassConstructorBuilderParameterName(ManifestItem item) =>
      '${item.shortName}Builder';

  Iterable<String> blocClassConstructorBlocParameters() => [
        [
          '${manifest.blocName}?',
          'bloc',
        ].joinDeclaration(),
        [
          'BlocBuilderCondition<${manifest.name}>?',
          'buildWhen',
        ].joinDeclaration(),
      ];

  String blocClassConstructorSuperKeyParameter() => [
        'key',
        ':',
        'key',
      ].joinDeclaration();

  String blocClassConstructorSuperBuilderParameter() => [
        'builder',
        ':',
        '_create${manifest.blocName}WidgetBuilder',
        '(',
        blocClassConstructorSuperBuilderParameterCreatorParameters(),
        ')',
      ].joinDeclaration();

  String blocClassConstructorSuperBuilderParameterCreatorParameters() =>
      manifest.items
          .map((e) => blocClassConstructorBuilderParameterName(e))
          .map((e) => '$e : $e')
          .joinArgsFull();

  Iterable<String> blocClassConstructorSuperBlocParameters() => [
        [
          'bloc',
          ':',
          'bloc',
        ].joinDeclaration(),
        [
          'buildWhen',
          ':',
          'buildWhen',
        ].joinDeclaration(),
      ];

  String blocBuilderFunction() {
    return <String>[
      'BlocWidgetBuilder<${manifest.name}>',
      '_create${manifest.blocName}WidgetBuilder',
      '({',
      blocClassConstructorBuilderParameters().joinArgsFull(),
      '}) {',
      'return (context, state) {',
      'return state.when<Widget>(',
      ...blocBuilderFunctionWhenCases(),
      ');',
      '};',
      '}',
    ].joinDeclaration();
  }

  Iterable<String> blocBuilderFunctionWhenCases() =>
      manifest.items.map((e) => blocBuilderFunctionWhenCase(e));

  String blocBuilderFunctionWhenCase(ManifestItem item) {
    return <String>[
      item.shortName,
      ':',
      '(',
      blocBuilderParameterNames(item).joinArgsSimple(),
      ')',
      '=>',
      blocClassConstructorBuilderParameterName(item),
      '(',
      [
        'context',
        ...blocBuilderParameterNames(item),
      ].joinArgsSimple(),
      '),',
    ].joinDeclaration();
  }
}
