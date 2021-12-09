import 'package:flutter/material.dart';
import 'package:manager/widgets/todo/add_todo.dart';
import 'package:manager/widgets/todo/completion_counter.dart';
import 'package:manager/widgets/todo/todo_item.dart';
import 'package:manager/widgets/todo/todo_list.dart';
import 'package:uuid/uuid.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final List<TodoItem> todos = [
    TodoItem(id: const Uuid(), title: "Clean Room", isCompleted: false),
    TodoItem(id: const Uuid(), title: "Pet the Cat", isCompleted: false),
    TodoItem(id: const Uuid(), title: "Dance", isCompleted: true)
  ];
  void _toggleAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return AddTodo(
            addTodo: _addTodo,
          );
        });
  }

  void _addTodo(String taskName) {
    setState(() {
      todos
          .add(TodoItem(id: const Uuid(), title: taskName, isCompleted: false));
    });
    return;
  }

  void _toggleCompleted(int index) {
    setState(() {
      todos[index].isCompleted = !todos[index].isCompleted;
    });
    return;
  }

  int _countCompleted() {
    var count = 0;
    for (var task in todos) {
      if (task.isCompleted) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CompletionCounter(
                completedCount: _countCompleted(),
                totalCount: todos.length,
              ),
              TodoList(todoItems: todos, toggleCompleted: _toggleCompleted)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _toggleAddTodoModal(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
