import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:surrealdb/surrealdb.dart';

part 'todos_provider.g.dart';

@Riverpod(dependencies: [db])
Future<List<Map<String, Object?>>> todos(TodosRef ref) async {
  final db = await ref.watch(dbProvider.future);
  return await db.select("Todos");
}

@Riverpod(dependencies: [])
Future<SurrealDB> db(DbRef ref) async {
  final client = SurrealDB('wss://sdb.up.railway.app/rpc');

  client.connect();
  await client.wait();
  await client.use('test', 'test');
  await client.signin(user: 'root', pass: 'root');
  return client;
}
