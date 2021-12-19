import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/model/event.dart';
import 'package:manager/model/event_data_source.dart';
import 'package:manager/view/event_viewing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TasksWidget extends StatelessWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventNotifier>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text("No events found!", style: TextStyle(fontSize: 24)),
      );
    }
    Widget appointmentBuilder(
        BuildContext context, CalendarAppointmentDetails details) {
      final Event event = details.appointments.first;
      return Center(
        child: Container(
          decoration:
              BoxDecoration(color: event.backgroundColor.withOpacity(0.5)),
          width: details.bounds.width,
          height: details.bounds.height,
          child: Text(event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      );
    }

    return SfCalendar(
      view: CalendarView.timelineDay,
      dataSource: EventDataSource(provider.eventList),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      onTap: (details) {
        if (details.appointments == null) {
          return;
        }
        final event = details.appointments!.first;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event)));
      },
    );
  }
}
