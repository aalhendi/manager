import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manager/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _date = DateTime.now();
  @override
  Widget build(BuildContext context) {
    String formattedDate = Utils.toDate(_date);
    return Center(
      child: Column(
        children: [
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
