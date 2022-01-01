import 'package:sealed_writer/src/manifest/manifest.dart';
import 'package:sealed_writer/src/utils/string_utils.dart';
import 'package:sealed_writer/src/writer/base/base_writer.dart';
import 'package:sealed_writer/src/writer/bloc/bloc_writer.dart';
import 'package:sealed_writer/src/writer/sub/sub_writer.dart';
import 'package:sealed_writer/src/writer/top/top_writer.dart';

/// source writer
///
/// NOTE: writer phase is completely disjoint from reader phase.
class SourceWriter extends BaseWriter {
  /// [referToManifest] dictates weather to reference
  /// manifest with @SealedManifest or not, it is true by default
  SourceWriter(
    Manifest manifest, {
    bool referToManifest = true,
  })  : topWriter = TopWriter(
          manifest,
          referToManifest: referToManifest,
        ),
        subWriter = SubWriter(manifest),
        blocWriter = BlocWriter(manifest),
        super(manifest);

  final TopWriter topWriter;

  final SubWriter subWriter;

  final BlocWriter blocWriter;

  Iterable<String> classes() => [
        topWriter.topClass(),
        ...subWriter.subClasses(),
        ...blocWriter.blocClasses(),
      ];

  String write() => classes().joinMethods();
}
