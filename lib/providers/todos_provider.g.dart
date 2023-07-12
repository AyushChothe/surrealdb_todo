// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbHash() => r'2dbec5043c6630b8570707b32ed4225e93aa3de0';

/// See also [db].
@ProviderFor(db)
final dbProvider = AutoDisposeProvider<SurrealDB>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DbRef = AutoDisposeProviderRef<SurrealDB>;
String _$todoControllerHash() => r'85f07fa1a305df870b0a57d03be249bb745ed9e5';

/// See also [todoController].
@ProviderFor(todoController)
final todoControllerProvider = AutoDisposeProvider<dynamic>.internal(
  todoController,
  name: r'todoControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TodoControllerRef = AutoDisposeProviderRef<dynamic>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
