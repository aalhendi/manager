import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/widgets/todo/add_todo.dart';
import 'package:manager/widgets/todo/completion_counter.dart';
import 'package:manager/widgets/todo/todo_list.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  void _toggleAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return const AddTodo();
        });
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
                completedCount: context.read<TodoNotifier>().countCompleted(),
                totalCount: context.watch<TodoNotifier>().todoList.length,
              ),
              const TodoList()
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
