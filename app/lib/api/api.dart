import 'package:manager/model/event.dart';
import 'package:manager/model/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class API {
  static final API instance = API._init();
  static Database? _database;

  API._init();

  factory API() {
    return instance;
  }

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
      ${EventFields.backgroundColor} $textType,
      ${EventFields.createdAt} $textType
    )
      ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
