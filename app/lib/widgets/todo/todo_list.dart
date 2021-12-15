import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/widgets/todo/todo_card.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return TodoCard(
            id: context.watch<TodoNotifier>().todoList[idx].id.toString(),
            title: context.watch<TodoNotifier>().todoList[idx].title,
            isCompleted:
                context.watch<TodoNotifier>().todoList[idx].isCompleted,
            createdAt: context.watch<TodoNotifier>().todoList[idx].createdAt,
            index: idx,
          );
        },
        itemCount: context.watch<TodoNotifier>().todoList.length,
      ),
    );
  }
}
