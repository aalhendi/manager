import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/model/event_data_source.dart';
import 'package:manager/view/event_editing_page.dart';
import 'package:manager/widgets/tasks_widget.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      body: SfCalendar(
        dataSource: EventDataSource(context.watch<EventNotifier>().eventList),
        view: CalendarView.month,
        initialSelectedDate: now,
        onLongPress: (calendarLongPressDetails) {
          Provider.of<EventNotifier>(context, listen: false).setDate(
              calendarLongPressDetails.date!.add(Duration(hours: now.hour)));
          showModalBottomSheet(
            context: context,
            builder: (context) => const TasksWidget(),
          );
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
