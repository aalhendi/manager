import 'package:flutter/material.dart';
import 'package:manager/controller/todo_notifier.dart';
import 'package:manager/utils/custom_search_delegate.dart';
import 'package:manager/view/calendar.dart';
import 'package:manager/view/contacts.dart';
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
  Widget build(BuildContext context) {
    List pages = [
      {
        "name": "Home",
        "icon": Icons.home,
        "body": const Center(
          child: Text("Home Screeen"),
        )
      },
      {
        "name": "To Do",
        "icon": Icons.list_alt,
        "body": const TodoPage(),
        "trailingText":
            "${context.watch<TodoNotifier>().todoList.where((e) => e.isCompleted == false).length}",
      },
      {"name": "Calendar", "icon": Icons.today, "body": const Calendar()},
      {"name": "Contacts", "icon": Icons.contacts, "body": const Contacts()},
      {"name": "Settings", "icon": Icons.settings, "body": const Settings()},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manager"),
        backgroundColor: Colors.black87,
        leading: Image.asset("images/logo.png"),
        actions: [
          IconButton(
              onPressed: () => {
                    showSearch(
                        context: context, delegate: CustomSearchDelegate())
                  },
              highlightColor: Colors.yellow,
              splashColor: Colors.blue,
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
