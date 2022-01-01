import 'package:sealed_generators/src/source/source_reader.dart';
import 'package:sealed_writer/sealed_writer.dart';
import 'package:test/test.dart';

import '../utils/exception_utils.dart';
import 'utils/read_utils.dart';

void main() {
  group('manifest reader', () {
    group('should success if', () {
      group('null-safe', () {
        group('simple', () {
          test('basic', () async {
            final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one();
void two(int x, double? y);
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic',
                params: [],
                fields: [],
                items: [
                  ManifestItem(
                    name: 'BasicOne',
                    shortName: 'one',
                    equality: ManifestEquality.data,
                    fields: [],
                  ),
                  ManifestItem(
                    name: 'BasicTwo',
                    shortName: 'two',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'x',
                        type: ManifestType(
                          name: 'int',
                          isNullable: false,
                        ),
                        defaultValueCode: null,
                      ),
                      ManifestField(
                        name: 'y',
                        type: ManifestType(
                          name: 'double',
                          isNullable: true,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });

          test('equality', () async {
            final x = await resolveSealedSafe('''
@Sealed()
@WithEquality(Equality.identity)
abstract class _Basic {
void one();
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic',
                params: [],
                fields: [],
                items: [
                  ManifestItem(
                    name: 'BasicOne',
                    shortName: 'one',
                    equality: ManifestEquality.identity,
                    fields: [],
                  ),
                ],
              ),
            );
          });

          group('meta', () {
            test('change name', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName('Hello')
void one();
}''');
              final reader = SourceReader();
              final manifest = reader.read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'Hello',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [],
                    ),
                  ],
                ),
              );
            });

            test('change equality', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithEquality(Equality.identity)
void one();
}''');
              final reader = SourceReader();
              final manifest = reader.read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.identity,
                      fields: [],
                    ),
                  ],
                ),
              );
            });

            test('change name and equality', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName('Hello')
@WithEquality(Equality.identity)
void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'Hello',
                      shortName: 'one',
                      equality: ManifestEquality.identity,
                      fields: [],
                    ),
                  ],
                ),
              );
            });

            test('change prefix', () async {
              final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix('Pre')
abstract class _Basic {
void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'PreOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [],
                    ),
                  ],
                ),
              );
            });

            test('empty prefix', () async {
              final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix('')
abstract class _Basic {
void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'One',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [],
                    ),
                  ],
                ),
              );
            });

            test('change prefix and name', () async {
              final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix('Pre')
abstract class _Basic {
@WithName('Hello')
void one();
}''');
              final reader = SourceReader();
              final manifest = reader.read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [],
                  items: [
                    ManifestItem(
                      name: 'Hello',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [],
                    ),
                  ],
                ),
              );
            });
          });

          test('withType', () async {
            final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one(@WithType('double?') x, @WithType('double') int? y);
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic',
                params: [],
                fields: [],
                items: [
                  ManifestItem(
                    name: 'BasicOne',
                    shortName: 'one',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'x',
                        type: ManifestType(
                          name: 'double',
                          isNullable: true,
                        ),
                        defaultValueCode: null,
                      ),
                      ManifestField(
                        name: 'y',
                        type: ManifestType(
                          name: 'double',
                          isNullable: false,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });

          test('hierarchy', () async {
            final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic1 {
void one(_Basic2 x);
}

@Sealed()
abstract class _Basic2 {
void one();
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic1',
                params: [],
                fields: [],
                items: [
                  ManifestItem(
                    name: 'Basic1One',
                    shortName: 'one',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'x',
                        type: ManifestType(
                          name: 'Basic2',
                          isNullable: false,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });

          group('common', () {
            test('basic', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
int get x;

void one(double y);
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'int',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'int',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                        ManifestField(
                          name: 'y',
                          type: ManifestType(
                            name: 'double',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });

            test('inherit', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
num get x;

void one();

void two(int x);
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'num',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'num',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                    ManifestItem(
                      name: 'BasicTwo',
                      shortName: 'two',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'int',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });

            test('final field', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
final int x = 0;

void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'int',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'int',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });

            test('basic meta', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithType('int')
dynamic get x;

void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'int',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'int',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });

            test('inherit meta', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
num get x;

void one(@WithType('int') dynamic x);
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'num',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                          name: 'x',
                          type: ManifestType(
                            name: 'int',
                            isNullable: false,
                          ),
                          defaultValueCode: null,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            });

            test('final field meta', () async {
              final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithType('int')
final dynamic x = null;

void one();
}''');
              final manifest = SourceReader().read(x.element, x.annotation);
              expect(
                manifest,
                Manifest(
                  name: 'Basic',
                  params: [],
                  fields: [
                    ManifestField(
                      name: 'x',
                      type: ManifestType(
                        name: 'int',
                        isNullable: false,
                      ),
                      defaultValueCode: null,
                    ),
                  ],
                  items: [
                    ManifestItem(
                      name: 'BasicOne',
                      shortName: 'one',
                      equality: ManifestEquality.data,
                      fields: [
                        ManifestField(
                            name: 'x',
                            type: ManifestType(
                              name: 'int',
                              isNullable: false,
                            ),
                            defaultValueCode: null),
                      ],
                    ),
                  ],
                ),
              );
            });
          });
        });

        group('generic', () {
          test('basic', () async {
            final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic<T extends num, E extends Object?> {
void one(T x);
void two(E y);
void three(T? z);
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic',
                fields: [],
                params: [
                  ManifestParam(
                    name: 'T',
                    bound: ManifestType(
                      name: 'num',
                      isNullable: false,
                    ),
                  ),
                  ManifestParam(
                    name: 'E',
                    bound: ManifestType(
                      name: 'Object',
                      isNullable: true,
                    ),
                  ),
                ],
                items: [
                  ManifestItem(
                    name: 'BasicOne',
                    shortName: 'one',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'x',
                        type: ManifestType(
                          name: 'T',
                          isNullable: false,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                  ManifestItem(
                    name: 'BasicTwo',
                    shortName: 'two',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'y',
                        type: ManifestType(
                          name: 'E',
                          isNullable: false,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                  ManifestItem(
                    name: 'BasicThree',
                    shortName: 'three',
                    equality: ManifestEquality.data,
                    fields: [
                      ManifestField(
                        name: 'z',
                        type: ManifestType(
                          name: 'T',
                          isNullable: true,
                        ),
                        defaultValueCode: null,
                      ),
                    ],
                  ),
                ],
              ),
            );
          });

          test('default bound', () async {
            final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic<T> {
void one();
}''');
            final manifest = SourceReader().read(x.element, x.annotation);
            expect(
              manifest,
              Manifest(
                name: 'Basic',
                fields: [],
                params: [
                  ManifestParam(
                    name: 'T',
                    bound: ManifestType(
                      name: 'Object',
                      isNullable: true,
                    ),
                  ),
                ],
                items: [
                  ManifestItem(
                    name: 'BasicOne',
                    shortName: 'one',
                    equality: ManifestEquality.data,
                    fields: [],
                  ),
                ],
              ),
            );
          });
        });
      });
    });

    group('should fail if', () {
      test('when is not nul-safe', () async {
        final x = await resolveSealedNonNullSafe('''
@Sealed()
abstract class _Basic {
void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('upper method name', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void One();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('lower class name', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _basic {
void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('upper field name', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one(int X);
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('upper common field name', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
int get X;

void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('non class element of enum', () async {
        final x = await resolveSealedSafe('''
@Sealed()
enum _Basic {
a, b, c,
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('non class element of method', () async {
        final x = await resolveSealedSafe('''
@Sealed()
void hello() {}
''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('public element', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class Basic {
void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('private method', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void _one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('private method argument', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one(int _x);
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('private getter', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
int get _x;

void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('with super type', () async {
        final x = await resolveSealedSafe('''
class S {}

@Sealed()
abstract class _Basic extends S {
void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('with super interface', () async {
        final x = await resolveSealedSafe('''
abstract class S {}

@Sealed()
abstract class _Basic implements S {
void one();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('with super type of Object', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic extends Object {
void one();
}''');
        final reader = SourceReader();
        expect(
            () => reader.read(x.element, x.annotation),
            isNot(
              throwsA(anything),
            ));
      });

      test('no items', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      test('method with type params', () async {
        final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one<T>();
}''');
        final reader = SourceReader();
        expect(
          () => reader.read(x.element, x.annotation),
          throwsSealedErrorNotInternal(),
        );
      });

      group('WithType with bad type', () {
        test('space', () async {
          final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
void one(@WithType("Hello ") x);
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });
      });

      group('Meta with bad name', () {
        test('top space', () async {
          final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix("Hel lo")
abstract class _Basic {
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('sub space', () async {
          final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName("Hel lo")
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('top nullability', () async {
          final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix("Hello?")
abstract class _Basic {
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('sub nullability', () async {
          final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName("Hello?")
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('top lower start', () async {
          final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix("hello")
abstract class _Basic {
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('sub lower start', () async {
          final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName("hello")
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('top private', () async {
          final x = await resolveSealedSafe('''
@Sealed()
@WithPrefix("_Hello")
abstract class _Basic {
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });

        test('sub private', () async {
          final x = await resolveSealedSafe('''
@Sealed()
abstract class _Basic {
@WithName("_Hello")
void one();
}''');
          final reader = SourceReader();
          expect(
            () => reader.read(x.element, x.annotation),
            throwsSealedErrorNotInternal(),
          );
        });
      });
    });
  });
}
