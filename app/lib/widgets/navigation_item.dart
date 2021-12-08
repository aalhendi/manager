import 'package:flutter/material.dart';

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
      this.trailingText = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected
          ? Theme.of(context).primaryColor.withOpacity(0.125)
          : Colors.transparent,
      child: ListTile(
        title: Text(name),
        selected: isSelected,
        leading: IconButton(
            onPressed: () {
              setIndex(index);
              Navigator.of(context).pop();
            },
            icon: Icon(
              icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.black,
            )),
        trailing: trailingText!.isNotEmpty
            ? Text(
                trailingText!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              )
            : null,
      ),
    );
  }
}
