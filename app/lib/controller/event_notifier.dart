import 'package:flutter/material.dart';
import 'package:manager/model/event.dart';
import 'package:manager/service/event_service.dart';

class EventNotifier extends ChangeNotifier {
  List<Event> _eventList = [];
  List<Event> get eventList => _eventList;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;
  List<Event> get eventsOfSelectedDate => _eventList;

  final EventService _eventService = EventService();

  void fetchEvents() async {
    _eventList = await _eventService.fetchEvents();
    notifyListeners();
  }

  addEvent(Event event) async {
    _eventList.add(event);
    await _eventService.addEvent(event);
    notifyListeners();
  }

  deleteEvent(int index, String id) async {
    _eventList.removeWhere((_event) => _event.id == eventList[index].id);
    await _eventService.deleteEvent(id);
    notifyListeners();
  }

  updateEvent(Event newEvent, int index) async {
    _eventList[index] = newEvent;
    await _eventService.updateEvent(newEvent);
    notifyListeners();
  }

  getIndex(String id) {
    return _eventList.indexWhere((e) => e.id == id);
  }
}
