import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  final String id;
  final String title;
  final bool isCompleted;
  final int index;

  const TodoCard({
    Key? key,
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          context.read<TodoNotifier>().toggleCompleted(index);
        },
        child: FractionallySizedBox(
            widthFactor: 0.9,
            child: Card(
                child: Container(
              padding: const EdgeInsets.all(20),
              height: 125,
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    isCompleted ? Icons.check : Icons.close,
                    color: isCompleted ? Colors.green : Colors.red,
                  )
                ],
              )),
            ))));
  }
}
