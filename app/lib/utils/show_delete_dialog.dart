import 'package:flutter/material.dart';

Future<void> showDeleteDialog(BuildContext context,
    Function(int, String) deleteFn, int index, String id) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: const Text("Confirm Delete"),
            contentPadding: const EdgeInsets.all(20.0),
            children: <Widget>[
              const Text("Are you sure you wish to delete this item?"),
              Row(children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () async {
                      await deleteFn(index, id);
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    )),
              ], mainAxisAlignment: MainAxisAlignment.center)
            ],
          ));
}
