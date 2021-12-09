import 'package:flutter/material.dart';
import 'package:manager/widgets/navigation_item.dart';

class Sidenav extends StatelessWidget {
  final int selectedIndex;
  final Function setIndex;
  final List pages;

  const Sidenav(
      {Key? key,
      required this.setIndex,
      required this.selectedIndex,
      required this.pages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> result = [
      Padding(
        padding: const EdgeInsets.all(16.0),
        // TODO: Font selection?
        child: Text(
          "Manager",
          style: TextStyle(fontSize: 21, color: Theme.of(context).primaryColor),
        ),
      ),
      Divider(
        color: Colors.grey.shade400,
      ),
    ];
    for (var i = 0; i < pages.length; i++) {
      if (pages[i]['name'] == 'Settings') {
        result.add(
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
        );
      }
      result.add(NavigationItem(
        isSelected: selectedIndex == i,
        index: i,
        setIndex: setIndex,
        name: pages[i]["name"],
        icon: pages[i]["icon"],
        trailingText: pages[i]['trailingText'],
      ));
      if (pages[i]['name'] == 'Home') {
        result.add(
          Divider(
            color: Colors.grey.shade400,
          ),
        );
      }
    }

    return Drawer(
      child: ListView(
        children: result,
      ),
    );
  }
}
