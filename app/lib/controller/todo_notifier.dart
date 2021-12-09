import 'package:flutter/material.dart';
import 'package:manager/model/todo_item.dart';
import 'package:manager/service/todo_service.dart';

class TodoNotifier extends ChangeNotifier {
  List<TodoItem> _todoList = [];
  List<TodoItem> get todoList => _todoList;

  final TodoService _todoService = TodoService();

  void fetchTodos() async {
    _todoList = await _todoService.fetchTodos();
    print(_todoList.length);
    notifyListeners();
  }
}
