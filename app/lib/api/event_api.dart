import 'package:manager/model/event.dart';
import 'package:manager/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class EventApi {
  static final EventApi instance = EventApi._init();

  EventApi._init();

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
      ${TodoFields.id} $idType,
      ${TodoFields.title} $textType,
      ${TodoFields.isCompleted} $boolType,
      ${TodoFields.createdAt} $textType
    )
      ''');
    await db.execute('''
    CREATE TABLE $tableEvents (
      ${EventFields.id} $idType,
      ${EventFields.title} $textType,
      ${EventFields.description} TEXT,
      ${EventFields.isAllDay} $boolType,
      ${EventFields.from} $textType,
      ${EventFields.to} $textType,
      ${EventFields.createdAt} $textType
    )
      ''');
  }

  Future<List<Event>> events() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(tableEvents);

    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<Event> event(String id) async {
    final db = await instance.database;
    final maps = await db
        .query(tableEvents, where: '${EventFields.id} = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Event.fromMap(maps.first);
    } else {
      throw Exception("ID $id not found.");
    }
  }

  Future<void> insertEvent(Event event) async {
    final db = await instance.database;

    await db.insert(
      tableEvents,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEvent(Event event) async {
    final db = await instance.database;

    await db.update(
      tableEvents,
      event.toMap(),
      where: '${EventFields.id} = ?',
      whereArgs: [event.id],
    );
  }

  Future<void> deleteEvent(String id) async {
    final db = await instance.database;

    await db.delete(
      tableEvents,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
