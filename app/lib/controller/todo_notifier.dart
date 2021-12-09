import 'package:flutter/material.dart';
import 'package:manager/model/todo_item.dart';
import 'package:manager/service/todo_service.dart';

class TodoNotifier extends ChangeNotifier {
  List<TodoItem> _todoList = [];
  List<TodoItem> get todoList => _todoList;

  final TodoService _todoService = TodoService();

  void fetchTodos() async {
    _todoList = await _todoService.fetchTodos();
    notifyListeners();
  }

  addTodo(TodoItem todo) {
    _todoList.add(todo);
    notifyListeners();
  }

  deleteTodo(int index) {
    _todoList.removeWhere((_todo) => _todo.id == todoList[index].id);
    notifyListeners();
  }

  toggleCompleted(int index) {
    todoList[index].isCompleted = !todoList[index].isCompleted;
    notifyListeners();
  }

  int countCompleted() {
    var count = 0;
    for (var task in todoList) {
      if (task.isCompleted) {
        count++;
      }
    }
    return count;
  }
}
