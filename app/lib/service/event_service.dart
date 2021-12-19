import 'package:manager/model/event.dart';
import 'package:manager/repository/event_repository.dart';

class EventService {
  final EventRepository _eventRepository = EventRepository();

  Future<List<Event>> fetchEvents() {
    // Do any bussiness logic here before returning
    return _eventRepository.fetchAllEvents();
  }

  Future<void> addEvent(Event event) {
    return _eventRepository.addEvent(event);
  }

  Future<void> updateEvent(Event newEvent) {
    return _eventRepository.updateEvent(newEvent);
  }

  Future<void> deleteEvent(String id) {
    return _eventRepository.deleteEvent(id);
  }
}
