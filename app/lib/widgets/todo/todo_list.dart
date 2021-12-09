import 'package:flutter/material.dart';
import 'package:manager/widgets/todo/todo_card.dart';
import 'package:manager/model/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<TodoItem> todoItems;
  final Function(int) toggleCompleted;

  const TodoList(
      {Key? key, required this.todoItems, required this.toggleCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView.builder(
        itemBuilder: (ctx, idx) {
          return TodoCard(
            id: todoItems[idx].id.toString(),
            title: todoItems[idx].title,
            isCompleted: todoItems[idx].isCompleted,
            index: idx,
            toggleCompleted: toggleCompleted,
          );
        },
        itemCount: todoItems.length,
      ),
    );
  }
}
