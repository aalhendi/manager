import 'package:manager/model/todo_item.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

///A useful abstraction layer between services and data.
class TodoRepository {
  Future<List<TodoItem>> fetchAllTodos() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<TodoItem> todos = [
      TodoItem(id: const Uuid(), title: "Clean Room", isCompleted: false),
      TodoItem(id: const Uuid(), title: "Pet the Cat", isCompleted: false),
      TodoItem(id: const Uuid(), title: "Dance", isCompleted: true)
    ];
    return todos;
  }

  // // Define a function that inserts dogs into the database
  // Future<void> insertDog(TodoItem todo) async {
  //   // Get a reference to the database.
  //   final db = await database;

  //   // Insert the TodoItem into the correct table. You might also specify the
  //   // `conflictAlgorithm` to use in case the same Todo is inserted twice.
  //   //
  //   // In this case, replace any previous data.
  //   await db.insert(
  //     'todos',
  //     todo.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
}
