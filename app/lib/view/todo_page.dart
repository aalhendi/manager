import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/widgets/todo/add_todo.dart';
import 'package:manager/widgets/todo/completion_counter.dart';
import 'package:manager/model/todo_item.dart';
import 'package:manager/widgets/todo/todo_list.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<TodoNotifier>(context, listen: false).fetchTodos();
    });
  }

  //TODO: Remove and begin using new architecture
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
                totalCount: context.watch<TodoNotifier>().todoList.length,
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
