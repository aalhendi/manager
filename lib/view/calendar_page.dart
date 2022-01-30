import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/model/event_data_source.dart';
import 'package:manager/view/event_editing_page.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'event_viewing_page.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // TODO: Fix bottom nav selectedIndex when controller.view changes
  final CalendarController _controller = CalendarController();
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.view = _calendarViews[_selectedIndex];
    });
  }

  static const List<CalendarView> _calendarViews = [
    CalendarView.month,
    CalendarView.week,
    CalendarView.day,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek
  ];

  @override
  Widget build(BuildContext context) {
    Widget buildBottomNavigation() => BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_month),
              label: "Month",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_week),
              label: "Week",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.view_day), label: "Day")
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        );

    void calendarTapped(CalendarTapDetails calendarTapDetails) {
      if (_controller.view == CalendarView.month &&
          calendarTapDetails.targetElement == CalendarElement.calendarCell) {
        _controller.view = CalendarView.day;
      } else if ((_controller.view == CalendarView.week ||
              _controller.view == CalendarView.workWeek) &&
          calendarTapDetails.targetElement == CalendarElement.viewHeader) {
        _controller.view = CalendarView.day;
      } else if (calendarTapDetails.targetElement ==
          CalendarElement.appointment) {
        final event = calendarTapDetails.appointments!.first;
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewingPage(event: event)));
      }
    }

    Widget buildSFCalendar() => SfCalendar(
          dataSource: EventDataSource(context.watch<EventNotifier>().eventList),
          view: _calendarViews[_selectedIndex],
          initialSelectedDate: DateTime.now(),
          showDatePickerButton: true,
          allowViewNavigation: true,
          controller: _controller,
          firstDayOfWeek: 7,
          allowedViews: _calendarViews,
          timeSlotViewSettings: const TimeSlotViewSettings(
              nonWorkingDays: <int>[DateTime.saturday, DateTime.friday]),
          onTap: calendarTapped,
        );

    return Scaffold(
      bottomNavigationBar: buildBottomNavigation(),
      body: buildSFCalendar(),
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
