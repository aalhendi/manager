import 'package:manager/model/event.dart';
import 'package:manager/api/event_API.dart';

class EventService {
  final EventAPI _eventAPI = EventAPI();

  Future<List<Event>> fetchEvents() {
    // Do any bussiness logic here before returning
    return _eventAPI.fetchAllEvents();
  }

  Future<void> addEvent(Event event) {
    return _eventAPI.addEvent(event);
  }

  Future<void> updateEvent(Event newEvent) {
    return _eventAPI.updateEvent(newEvent);
  }

  Future<void> deleteEvent(String id) {
    return _eventAPI.deleteEvent(id);
  }
}
