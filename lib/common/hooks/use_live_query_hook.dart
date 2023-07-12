import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:surrealdb/surrealdb.dart';

List<T> useLiveQuery<T extends Object>(
  String query, {
  required SurrealDB client,
  required T Function(Map<String, dynamic>) fromJson,
  bool initalFetch = true,
}) {
  return use<List<T>>(LiveQuery<T>(query, fromJson: fromJson, client: client));
}

class LiveQuery<T extends Object> extends Hook<List<T>> {
  const LiveQuery(
    this.query, {
    required this.fromJson,
    required this.client,
    this.initalFetch = true,
  });
  final String query;
  final bool initalFetch;

  final T Function(Map<String, dynamic>) fromJson;

  final SurrealDB client;

  @override
  LiveQueryState<T> createState() => LiveQueryState<T>();
}

class LiveQueryState<T extends Object>
    extends HookState<List<T>, LiveQuery<T>> {
  late final String queryUuid;

  List<Map<String, dynamic>> state = [];

  @override
  void initHook() {
    super.initHook();
    initStream(initalFetch: hook.initalFetch);
  }

  @override
  void dispose() {
    hook.client.query("Kill '$queryUuid'");
    super.dispose();
  }

  void initStream({bool initalFetch = true}) async {
    if (initalFetch) {
      final res =
          ((await hook.client.query(hook.query) as List)[0]['result'] as List);
      state = res.cast();
    }

    queryUuid = parseUuid(
        ((await hook.client.query('Live ${hook.query}')) as List)[0]['result']);

    hook.client.listenLive(queryUuid, (res) {
      setState(() {
        state = switch (res.action) {
          LiveQueryAction.close => <Map<String, dynamic>>[],
          LiveQueryAction.create => [
              ...state,
              (res.result as Map<String, dynamic>)
            ],
          LiveQueryAction.update => [
              ...state.map((e) {
                final newT = (res.result as Map<String, dynamic>);
                return (e['id'] == newT['id']) ? newT : e;
              })
            ],
          LiveQueryAction.delete => [
              ...state..removeAt(state.indexWhere((e) => e['id'] == res.result))
            ]
        };
      });
    });
    setState(() {});
  }

  @override
  List<T> build(BuildContext context) => state.map(hook.fromJson).toList();
}
