import 'package:manager/model/todo.dart';
import 'package:manager/repository/todo_repository.dart';

class TodoService {
  final TodoRepository _todoRepository = TodoRepository();

  // TODO: Add checks to see if successful or not. Show dialogs or banners on fail

  Future<List<Todo>> fetchTodos() {
    // Do any bussiness logic here before returning
    return _todoRepository.fetchAllTodos();
  }

  Future<void> addTodo(Todo todo) {
    return _todoRepository.addTodo(todo);
  }

  Future<void> updateTodo(Todo newTodo) {
    return _todoRepository.updateTodo(newTodo);
  }

  Future<void> deleteTodo(String id) {
    return _todoRepository.deleteTodo(id);
  }
}
