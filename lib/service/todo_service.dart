import 'package:manager/model/todo.dart';
import 'package:manager/api/todo_api.dart';

class TodoService {
  final TodoAPI _todoAPI = TodoAPI();

  // TODO: Add checks to see if successful or not. Show dialogs or banners on fail

  Future<List<Todo>> fetchTodos() {
    // Do any bussiness logic here before returning
    return _todoAPI.fetchAllTodos();
  }

  Future<void> addTodo(Todo todo) {
    return _todoAPI.addTodo(todo);
  }

  Future<void> updateTodo(Todo newTodo) {
    return _todoAPI.updateTodo(newTodo);
  }

  Future<void> deleteTodo(String id) {
    return _todoAPI.deleteTodo(id);
  }
}
