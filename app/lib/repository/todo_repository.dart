import 'package:manager/model/todo_item.dart';
import 'package:uuid/uuid.dart';

///A useful abstraction layer between services and data.
class TodoRepository {
  Future<List<TodoItem>> fetchAllTodos() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<TodoItem> todos = [
      TodoItem(id: const Uuid(), title: "Clean Room", isCompleted: false),
      TodoItem(id: const Uuid(), title: "Pet the Cat", isCompleted: false),
      TodoItem(id: const Uuid(), title: "Dance", isCompleted: true)
    ];
    return todos;
  }
}
