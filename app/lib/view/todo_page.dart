import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/model/todo.dart';
import 'package:manager/utils/show_delete_dialog.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _todoController = TextEditingController();

  Widget buildAddTodo() => Container(
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
                context.read<TodoNotifier>().addTodo(Todo(
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

  void _toggleAddTodoModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bCtx) {
          return buildAddTodo();
        });
  }

  @override
  Widget build(BuildContext context) {
    List<SlidableAction> buildSlidableActions({
      required Todo todo,
      required int index,
    }) {
      return [
        SlidableAction(
          onPressed: (_) {
            context.read<TodoNotifier>().updateTodo(
                Todo(
                    id: todo.id,
                    title: todo.title,
                    isCompleted: !todo.isCompleted,
                    createdAt: todo.createdAt),
                index);
          },
          backgroundColor: const Color(0xFF21B7CA),
          foregroundColor: Colors.white,
          icon: Icons.check_box_outlined,
          label: 'toggle',
        ),
        SlidableAction(
          onPressed: (context) {
            showDeleteDialog(context, context.read<TodoNotifier>().deleteTodo,
                index, todo.id);
          },
          backgroundColor: const Color(0xFFFE4A49),
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: 'Delete',
        )
      ];
    }

    //TODO: Better card design
    Widget buildTodoCard({
      required Todo todo,
      required int index,
    }) {
      return Slidable(
        key: ValueKey(todo.id), // key if Slidable dismissible.
        groupTag: '0', // Each group can only have one slidable open
        endActionPane: ActionPane(
          // The end action pane is the one at the right or the bottom side.
          motion:
              const ScrollMotion(), // used to control how the pane animates.
          children: buildSlidableActions(
            todo: todo,
            index: index,
          ),
        ),
        child: Card(
            child: Container(
          padding: const EdgeInsets.all(20),
          height: 125,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.title,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Icon(
                todo.isCompleted ? Icons.check : Icons.close,
                color: todo.isCompleted ? Colors.green : Colors.red,
              )
            ],
          )),
        )),
      );
    }

    Widget buildTodoList() {
      final todoNotifier = Provider.of<TodoNotifier>(context, listen: false);
      return SizedBox(
        height: 600,
        child: ListView.builder(
          itemBuilder: (ctx, idx) {
            Todo foundTodo = todoNotifier.todoList[idx];
            return buildTodoCard(
              todo: Todo(
                  id: foundTodo.id.toString(),
                  title: foundTodo.title,
                  isCompleted: foundTodo.isCompleted,
                  createdAt: foundTodo.createdAt),
              index: idx,
            );
          },
          itemCount: context.watch<TodoNotifier>().todoList.length,
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: buildTodoList(),
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
