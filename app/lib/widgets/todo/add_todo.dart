import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  final Function(String) addTodo;

  const AddTodo({Key? key, required this.addTodo}) : super(key: key);

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
                  widget.addTodo(_todoController.text);
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