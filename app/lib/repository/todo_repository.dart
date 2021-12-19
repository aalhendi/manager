import 'package:manager/api/todo_api.dart';
import 'package:manager/model/todo.dart';

///A useful abstraction layer between services and data.
class TodoRepository {
  Future<List<Todo>> fetchAllTodos() async {
    final List<Todo> todos = await TodoApi.instance.todos();
    return todos;
  }

  Future<void> addTodo(Todo todo) async {
    return await TodoApi.instance.insertTodo(todo);
  }

  Future<void> updateTodo(Todo newTodo) async {
    return await TodoApi.instance.updateTodo(newTodo);
  }

  Future<void> deleteTodo(String id) async {
    return await TodoApi.instance.deleteTodo(id);
  }
}
