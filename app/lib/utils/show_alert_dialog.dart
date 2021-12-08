import 'package:flutter/material.dart';

showAlertDialog(BuildContext context) {
  /* Button Setup */
  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Continue"),
    onPressed: () {},
  );

  /* Alert Dialog Setup */
  AlertDialog alert = AlertDialog(
    title: const Text("Alert"),
    content: const Text("Settings Pressed"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  /* Show Dialog */
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
