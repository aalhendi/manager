import 'package:flutter/material.dart';
import 'package:manager/widgets/completion_counter.dart';
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

class TodoItem {
  Uuid id;
  String title;
  bool isCompleted;

  TodoItem({required this.id, required this.title, required this.isCompleted});
}

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

class TodoCard extends StatelessWidget {
  final String id;
  final String title;
  final bool isCompleted;
  final int index;
  final Function(int) toggleCompleted;

  const TodoCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.isCompleted,
      required this.index,
      required this.toggleCompleted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          toggleCompleted(index);
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
