import 'package:manager/model/todo_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class TodoApi {
  static final TodoApi instance = TodoApi._init();

  TodoApi._init();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'TEXT PRIMARY KEY';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableTodos (
      ${TodoItemFields.id} $idType,
      ${TodoItemFields.title} $textType,
      ${TodoItemFields.isCompleted} $boolType,
      ${TodoItemFields.createdAt} $textType
    )
      ''');
  }

  // Define a function that inserts todos into the database
  Future<void> insertTodo(TodoItem todo) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Insert the TodoItem into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same Todo is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      tableTodos,
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the todos from the todos table.
  Future<List<TodoItem>> todos() async {
    // Get a reference to the database.
    final db = await instance.database;

    // Query the table for all The Todos.
    final List<Map<String, dynamic>> maps = await db.query(tableTodos);

    // Convert the List<Map<String, dynamic> into a List<TodoItem>.
    return List.generate(maps.length, (i) {
      return TodoItem.fromMap(maps[i]);
    });
  }

  Future<TodoItem> todo(String id) async {
    final db = await instance.database;
    final maps = await db
        .query(tableTodos, where: '${TodoItemFields.id} = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return TodoItem.fromMap(maps.first);
    } else {
      throw Exception("ID $id not found.");
    }
  }

  Future<void> updateTodo(TodoItem todo) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Update the given Todo.
    await db.update(
      tableTodos,
      todo.toMap(),
      // Ensure that the Todo has a matching id.
      where: '${TodoItemFields.id} = ?',
      // Pass the Todo's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  Future<void> deleteTodo(String id) async {
    // Get a reference to the database.
    final db = await instance.database;

    // Remove the Todo from the database.
    await db.delete(
      tableTodos,
      // Use a `where` clause to delete a specific Todo.
      where: '${TodoItemFields.id} = ?',
      // Pass the Todo's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
