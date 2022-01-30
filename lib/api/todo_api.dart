import 'package:manager/api/db_helper.dart';
import 'package:manager/model/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoAPI {
  static final DBHelper instance = DBHelper();

  Future<List<Todo>> fetchAllTodos() async {
    // Get a reference to the database.
    final db = await instance.database;

    // Query the table for all The Todos.
    final List<Map<String, dynamic>> maps = await db.query(tableTodos);

    // Convert the List<Map<String, dynamic> into a List<Todo>.
    return List.generate(maps.length, (i) {
      return Todo.fromMap(maps[i]);
    });
  }

  Future<void> addTodo(Todo todo) async {
    final db = await instance.database;
    // Insert the Todo into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same Todo is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      tableTodos,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTodo(Todo newTodo) async {
    final db = await instance.database;

    // Update the given Todo.
    await db.update(
      tableTodos,
      newTodo.toMap(),
      where: '${TodoFields.id} = ?',
      whereArgs: [newTodo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Remove the Todo from the database.
    await db.delete(
      tableTodos,
      // Use a `where` clause to delete a specific Todo.
      where: '${TodoFields.id} = ?',
      // Pass the Todo's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
