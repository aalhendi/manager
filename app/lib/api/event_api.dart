import 'package:manager/api/db_helper.dart';
import 'package:manager/model/event.dart';
import 'package:sqflite/sqflite.dart';

class EventAPI {
  static final DBHelper instance = DBHelper();

  Future<List<Event>> fetchAllEvents() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(tableEvents);

    return List.generate(maps.length, (i) {
      return Event.fromMap(maps[i]);
    });
  }

  Future<Event> fetchEvent(String id) async {
    final db = await instance.database;
    final maps = await db
        .query(tableEvents, where: '${EventFields.id} = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Event.fromMap(maps.first);
    } else {
      throw Exception("ID $id not found.");
    }
  }

  Future<void> addEvent(Event event) async {
    final db = await instance.database;

    await db.insert(
      tableEvents,
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateEvent(Event newEvent) async {
    final db = await instance.database;

    await db.update(
      tableEvents,
      newEvent.toMap(),
      where: '${EventFields.id} = ?',
      whereArgs: [newEvent.id],
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
}
