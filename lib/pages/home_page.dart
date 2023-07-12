import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surrealdb_todo/common/hooks/use_live_query_hook.dart';
import 'package:surrealdb_todo/common/models/todo.dart';
import 'package:surrealdb_todo/providers/todos_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(dbProvider);
    final todosCtrl = ref.watch(todoControllerProvider);
    final todos = useLiveQuery(
      "Select * From Todos",
      client: client,
      fromJson: TodoModel.fromJson,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("SurrealDB Todo"),
      ),
      body: Center(
        child: (todos.isEmpty)
            ? const Text("No Todos Found")
            : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    onTap: () async => await todosCtrl.toogleTodo(todo),
                    onLongPress: () async => await todosCtrl.deleteTodo(todo),
                    title: Text(todo.id!),
                    subtitle: Text(todo.isCompleted ? "Completed" : "Pending"),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await todosCtrl
              .addTodo(TodoModel(title: "Todo 1", desc: "Description 1"));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
