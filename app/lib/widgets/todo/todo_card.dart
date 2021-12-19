import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/model/todo.dart';
import 'package:manager/utils/show_delete_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoCard extends StatelessWidget {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  final int index;

  const TodoCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.isCompleted,
      required this.index,
      required this.createdAt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      // Specify a key if the Slidable is dismissible.
      key: ValueKey(id),

      // Each group can only have one slidable open
      groupTag: '0',

      // The end action pane is the one at the right or the bottom side.
      endActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (_) {
              context.read<TodoNotifier>().updateTodo(
                  Todo(
                      id: id,
                      title: title,
                      isCompleted: !isCompleted,
                      createdAt: createdAt),
                  index);
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.check_box_outlined,
            label: 'toggle',
          ),
          SlidableAction(
            onPressed: (context) {
              showDeleteDialog(
                  context, context.read<TodoNotifier>().deleteTodo, index, id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),

      // The child of the Slidable is what the user sees when the
      // component is not dragged.
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
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Icon(
              isCompleted ? Icons.check : Icons.close,
              color: isCompleted ? Colors.green : Colors.red,
            )
          ],
        )),
      )),
    );
  }
}
