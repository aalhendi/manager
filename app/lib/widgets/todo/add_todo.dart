import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/model/todo_item.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    Key? key,
  }) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _todoController,
              maxLength: 20,
              decoration: const InputDecoration(labelText: "Name of the task"),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<TodoNotifier>().addTodo(TodoItem(
                      id: const Uuid().v4(),
                      title: _todoController.text,
                      isCompleted: false,
                      createdAt: DateTime.now()));
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Add",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ))
          ],
        ));
  }
}
