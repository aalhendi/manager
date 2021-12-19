import 'package:flutter/material.dart';
import 'package:manager/model/todo.dart';
import 'package:manager/service/todo_service.dart';

class TodoNotifier extends ChangeNotifier {
  List<Todo> _todoList = [];
  List<Todo> get todoList => _todoList;

  final TodoService _todoService = TodoService();

  void fetchTodos() async {
    _todoList = await _todoService.fetchTodos();
    notifyListeners();
  }

  addTodo(Todo todo) async {
    _todoList.add(todo);
    await _todoService.addTodo(todo);
    notifyListeners();
  }

  deleteTodo(int index, String id) async {
    _todoList.removeWhere((_todo) => _todo.id == todoList[index].id);
    await _todoService.deleteTodo(id);
    notifyListeners();
  }

  updateTodo(Todo newTodo, int index) async {
    _todoList[index] = newTodo;
    await _todoService.updateTodo(newTodo);
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
