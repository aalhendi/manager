import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/model/event_data_source.dart';
import 'package:manager/view/event_editing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<EventNotifier>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        dataSource: EventDataSource(context.watch<EventNotifier>().eventList),
        view: CalendarView.month,
        initialSelectedDate: DateTime.now(),
        onLongPress: (calendarLongPressDetails) {
          Provider.of<EventNotifier>(context)
              .setDate(calendarLongPressDetails.date!);
        },
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
