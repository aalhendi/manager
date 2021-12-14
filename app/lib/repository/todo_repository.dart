import 'package:manager/api/todo_api.dart';
import 'package:manager/model/todo_item.dart';

///A useful abstraction layer between services and data.
class TodoRepository {
  Future<List<TodoItem>> fetchAllTodos() async {
    final List<TodoItem> todos = await TodoApi.instance.todos();
    return todos;
  }

  Future<void> addTodo(TodoItem todo) async {
    return await TodoApi.instance.insertTodo(todo);
  }

  Future<void> updateTodo(TodoItem newTodo) async {
    return await TodoApi.instance.updateTodo(newTodo);
  }

  Future<void> deleteTodo(String id) async {
    return await TodoApi.instance.deleteTodo(id);
  }
}
