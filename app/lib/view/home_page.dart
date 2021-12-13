import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // DateTime _datetime = DateTime(2020);
  DateTime _date = DateTime.now();
  DateFormat formatter = DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    String formattedDate = formatter.format(_date);
    return Center(
      child: Column(
        children: [
          const Text("Home"),
          ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          title: const Text("Title"),
                          contentPadding: const EdgeInsets.all(20.0),
                          children: [
                            const Text("data"),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("close"))
                          ],
                        ));
              },
              child: const Text("Open")),
          Text(
            formattedDate,
            style: const TextStyle(fontSize: 40),
          ),
          ElevatedButton(
              onPressed: () async {
                DateTime? _newDate = await showDatePicker(
                    context: context,
                    initialDate: _date,
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2050));
                if (_newDate != null) {
                  setState(() {
                    _date = _newDate;
                  });
                }
              },
              child: const Text("Get Date"))
        ],
      ),
    );
  }
}
