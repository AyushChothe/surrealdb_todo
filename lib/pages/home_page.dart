import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:surrealdb_todo/providers/todos_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(dbProvider.future);
    final todosList = ref.watch(todosProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("SurrealDB Todo"),
      ),
      body: Center(
        child: todosList.when(
          data: (todos) {
            if (todos.isEmpty) return const Text("No Todos Found");
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return ListTile(
                  onTap: () async {
                    await (await db).query(
                        "Update ${todo['id']} Set isDone=${!(todo["isDone"] as bool)}");
                    ref.invalidate(todosProvider);
                  },
                  onLongPress: () async {
                    await (await db).delete("${todo['id']}");
                    ref.invalidate(todosProvider);
                  },
                  title: Text(todo['id'].toString()),
                  subtitle:
                      Text(todo["isDone"] as bool ? "Completed" : "Pending"),
                );
              },
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await (await db).create("Todos", {"name": "Todo", "isDone": false});
          ref.invalidate(todosProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
