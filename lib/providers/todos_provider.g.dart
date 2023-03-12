// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todos_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosHash() => r'8e2a575b75c6f324a807d945049aa9d39a547e10';

/// See also [todos].
@ProviderFor(todos)
final todosProvider =
    AutoDisposeFutureProvider<List<Map<String, Object?>>>.internal(
  todos,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
  dependencies: <ProviderOrFamily>[dbProvider],
  allTransitiveDependencies: <ProviderOrFamily>[dbProvider],
);

typedef TodosRef = AutoDisposeFutureProviderRef<List<Map<String, Object?>>>;
String _$dbHash() => r'091f0d4be968ca941c34abfda01a2147dd948ab5';

/// See also [db].
@ProviderFor(db)
final dbProvider = AutoDisposeFutureProvider<SurrealDB>.internal(
  db,
  name: r'dbProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dbHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>[],
);

typedef DbRef = AutoDisposeFutureProviderRef<SurrealDB>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
