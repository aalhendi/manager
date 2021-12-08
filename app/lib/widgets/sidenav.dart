import 'package:flutter/material.dart';
import 'package:manager/widgets/navigation_item.dart';

class Sidenav extends StatelessWidget {
  final int selectedIndex;
  final Function setIndex;

  const Sidenav({Key? key, required this.setIndex, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            // TODO: Font selection?
            child: Text(
              "Manager",
              style: TextStyle(
                  fontSize: 21, color: Theme.of(context).primaryColor),
            ),
          ),
          Divider(
            color: Colors.grey.shade400,
          ),
          NavigationItem(
              isSelected: selectedIndex == 0,
              index: 0,
              setIndex: setIndex,
              name: "Home",
              icon: Icons.home),
          Divider(
            color: Colors.grey.shade400,
          ),
          // TODO: count incomplete todos
          NavigationItem(
              isSelected: selectedIndex == 1,
              index: 1,
              setIndex: setIndex,
              name: "To Do",
              trailingText: "2",
              icon: Icons.list_alt),
          NavigationItem(
              isSelected: selectedIndex == 2,
              index: 2,
              setIndex: setIndex,
              name: "Calendar",
              icon: Icons.today),
          NavigationItem(
              isSelected: selectedIndex == 3,
              index: 3,
              setIndex: setIndex,
              name: "Contacts",
              icon: Icons.contacts),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "OTHER",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                  letterSpacing: 1),
            ),
          ),
          NavigationItem(
              isSelected: selectedIndex == 4,
              index: 4,
              setIndex: setIndex,
              name: "Settings",
              icon: Icons.settings),
        ],
      ),
    );
  }
}
