import 'package:manager/model/todo_item.dart';
import 'package:manager/repository/todo_repository.dart';

class TodoService {
  final TodoRepository _todoRepository = TodoRepository();

  Future<List<TodoItem>> fetchTodos() {
    // Do any bussiness logic here before returning
    return _todoRepository.fetchAllTodos();
  }
}
