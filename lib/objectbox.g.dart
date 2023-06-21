// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'model/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3823431366324443925),
      name: 'User',
      lastPropertyId: const IdUid(6, 2703308920669830943),
      flags: 2,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6928404562426173305),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(4, 866402648181073234),
            name: 'userEmailAddress',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8614492763647544535),
            name: 'passwords',
            type: 30,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2703308920669830943),
            name: 'username',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 3823431366324443925),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [1463880056831665859, 8327452999560428252],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    User: EntityDefinition<User>(
        model: _entities[0],
        toOneRelations: (User object) => [],
        toManyRelations: (User object) => {},
        getId: (User object) => object.id,
        setId: (User object, int id) {
          object.id = id;
        },
        objectToFB: (User object, fb.Builder fbb) {
          final userEmailAddressOffset =
              fbb.writeString(object.userEmailAddress);
          final passwordsOffset = fbb.writeList(
              object.passwords.map(fbb.writeString).toList(growable: false));
          final usernameOffset = fbb.writeString(object.username);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(3, userEmailAddressOffset);
          fbb.addOffset(4, passwordsOffset);
          fbb.addOffset(5, usernameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = User(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              username: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 14, ''),
              userEmailAddress: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 10, ''),
              passwords: const fb.ListReader<String>(
                      fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGet(buffer, rootOffset, 12, []));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// see [User.id]
  static final id = QueryIntegerProperty<User>(_entities[0].properties[0]);

  /// see [User.userEmailAddress]
  static final userEmailAddress =
      QueryStringProperty<User>(_entities[0].properties[1]);

  /// see [User.passwords]
  static final passwords =
      QueryStringVectorProperty<User>(_entities[0].properties[2]);

  /// see [User.username]
  static final username = QueryStringProperty<User>(_entities[0].properties[3]);
}
