import 'package:manager/api/event_api.dart';
import 'package:manager/model/event.dart';

class EventRepository {
  Future<List<Event>> fetchAllEvents() async {
    final List<Event> events = await EventApi.instance.events();
    return events;
  }

  Future<void> addEvent(Event event) async {
    return await EventApi.instance.insertEvent(event);
  }

  Future<void> updateEvent(Event newEvent) async {
    return await EventApi.instance.updateEvent(newEvent);
  }

  Future<void> deleteEvent(String id) async {
    return await EventApi.instance.deleteEvent(id);
  }
}
