import 'package:flutter/material.dart';
import 'package:manager/controller/theme_notifier.dart';
import 'package:provider/provider.dart';

class NavigationItem extends StatelessWidget {
  final bool isSelected;
  final int index;
  final Function setIndex;
  final String name;
  final IconData icon;
  final String? trailingText;

  const NavigationItem(
      {Key? key,
      required this.isSelected,
      required this.index,
      required this.setIndex,
      required this.name,
      required this.icon,
      this.trailingText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    return GestureDetector(
      onTap: () {
        setIndex(index);
        Navigator.of(context).pop();
      },
      child: Container(
        color: isSelected
            ? Theme.of(context).colorScheme.secondary.withOpacity(0.125)
            : Colors.transparent,
        child: ListTile(
            title: Text(
              name,
              style: TextStyle(
                  color: isSelected
                      ? themeNotifier.themeData.colorScheme.secondary
                      : themeNotifier.themeData.colorScheme.onPrimary),
            ),
            selected: isSelected,
            leading: Icon(
              icon,
              color: isSelected
                  ? themeNotifier.themeData.colorScheme.secondary
                  : themeNotifier.themeData.colorScheme.onPrimary,
            ),
            trailing: Text(
              trailingText ?? "",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? themeNotifier.themeData.colorScheme.secondary
                    : themeNotifier.themeData.colorScheme.onPrimary,
              ),
            )),
      ),
    );
  }
}
