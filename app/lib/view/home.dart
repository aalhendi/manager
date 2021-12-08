import 'package:flutter/material.dart';
import 'package:manager/utils/custom_search_delegate.dart';
import 'package:manager/view/calendar.dart';
import 'package:manager/view/contacts.dart';
import 'package:manager/view/settings.dart';
import 'package:manager/view/todo.dart';
import 'package:manager/widgets/sidenav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
        selectedIndex: selectedIndex,
        setIndex: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      // TODO: Refactor somehow (?)
      body: Builder(builder: (context) {
        if (selectedIndex == 0) {
          return const Center(
            child: Text("Home Screen"),
          );
        } else if (selectedIndex == 1) {
          return const Todo();
        } else if (selectedIndex == 2) {
          return const Calendar();
        } else if (selectedIndex == 3) {
          return const Contacts();
        } else if (selectedIndex == 4) {
          return const Settings();
        } else {
          return const Center(
            child: Text("Failed to load page."),
          );
        }
      }),
    );
  }
}
