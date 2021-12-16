import 'package:flutter/material.dart';
import 'package:manager/view/event_editing_page.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const EventEditingPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
