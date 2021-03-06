import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/utils/custom_search_delegate.dart';
import 'package:manager/view/calendar_page.dart';
import 'package:manager/view/contacts.dart';
import 'package:manager/view/home_page.dart';
import 'package:manager/view/settings.dart';
import 'package:manager/view/todo_page.dart';
import 'package:manager/widgets/sidenav.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<TodoNotifier>(context, listen: false).fetchTodos();
      Provider.of<EventNotifier>(context, listen: false).fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    List pages = [
      {"name": "Home", "icon": Icons.home, "body": const HomePage()},
      {
        "name": "To Do",
        "icon": Icons.list_alt,
        "body": const TodoPage(),
        "trailingText":
            "${context.watch<TodoNotifier>().todoList.where((e) => e.isCompleted == false).length}",
      },
      {"name": "Calendar", "icon": Icons.today, "body": const CalendarPage()},
      {"name": "Contacts", "icon": Icons.contacts, "body": const Contacts()},
      {"name": "Settings", "icon": Icons.settings, "body": const Settings()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        // leading: Image.asset("images/logo.png"),
        //TODO: App logo
        leading: const Icon(
          Icons.menu_book,
          size: 32,
        ),
        actions: [
          IconButton(
              onPressed: () => {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate())
                  },
              icon: const Icon(Icons.search)),
        ],
      ),
      drawer: Sidenav(
        pages: pages,
        selectedIndex: selectedIndex,
        setIndex: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: Builder(builder: (context) {
        if (selectedIndex < pages.length) {
          return pages[selectedIndex]["body"];
        } else {
          return const Center(
            child: Text("Failed to load page."),
          );
        }
      }),
    );
  }
}
