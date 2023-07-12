import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surrealdb/surrealdb.dart';
import 'package:surrealdb_todo/pages/home_page.dart';
import 'package:surrealdb_todo/providers/todos_provider.dart';

void main() async {
  final client = SurrealDB('ws://localhost:8000/rpc');

  client.connect();
  await client.wait();
  await client.use('test', 'test');
  await client.signin(user: 'root', pass: 'root');

  runApp(
    ProviderScope(
      overrides: [dbProvider.overrideWithValue(client)],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
