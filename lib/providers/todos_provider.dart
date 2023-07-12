import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:surrealdb/surrealdb.dart';
import 'package:surrealdb_todo/common/models/todo.dart';

part 'todos_provider.g.dart';

@riverpod
SurrealDB db(DbRef ref) => SurrealDB('');

@riverpod
TodoController todoController(TodoControllerRef ref) {
  final db = ref.watch(dbProvider);
  return TodoController(db);
}

class TodoController {
  TodoController(this._client);

  final SurrealDB _client;
  final _todosTable = 'Todos';

  Future<void> addTodo(TodoModel tm) async {
    await _client.create(
        _todosTable, tm.toJson()..removeWhere((k, v) => v == null));
  }

  Future<void> toogleTodo(TodoModel tm) async {
    await _client.update(
        tm.id!, tm.copyWith(isCompleted: !tm.isCompleted).toJson());
  }

  Future<void> deleteTodo(TodoModel tm) async {
    await _client.delete(tm.id!);
  }
}
