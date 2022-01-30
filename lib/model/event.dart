import 'package:flutter/material.dart';
import 'package:manager/utils/hex_color.dart';

const String tableEvents = 'events';

class EventFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String isAllDay = 'isAllDay';
  static const String from = 'fromDate';
  static const String to = 'toDate';
  static const String backgroundColor = 'backgroundColor';
  static const String createdAt = 'createdAt';
}

class Event {
  final String id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;
  final DateTime createdAt;

  Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.from,
      required this.to,
      required this.backgroundColor,
      this.isAllDay = false,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return {
      EventFields.id: id,
      EventFields.title: title,
      EventFields.description: description,
      EventFields.isAllDay: isAllDay ? 1 : 0,
      EventFields.from: from.toIso8601String(),
      EventFields.backgroundColor:
          backgroundColor.toHex(leadingHashSign: false),
      EventFields.to: to.toIso8601String(),
      EventFields.createdAt: createdAt.toIso8601String()
    };
  }

  static Event fromMap(Map<String, Object?> map) => Event(
        id: map[EventFields.id] as String,
        title: map[EventFields.title] as String,
        description: map[EventFields.description] as String,
        isAllDay: map[EventFields.isAllDay] == 1,
        from: DateTime.parse(map[EventFields.from] as String),
        to: DateTime.parse(map[EventFields.to] as String),
        backgroundColor:
            HexColor.fromHex(map[EventFields.backgroundColor] as String),
        createdAt: DateTime.parse(map[EventFields.createdAt] as String),
      );

  @override
  String toString() {
    return 'Event{${EventFields.id}: $id, ${EventFields.title}: $title, ${EventFields.isAllDay}: $isAllDay}';
  }
}
