import 'package:flutter/material.dart';
import 'package:manager/model/event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

// TODO: Complete event editing page
class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildEditingActions() => [
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.done),
            label: const Text("SAVE"),
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
          ),
        ];
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
    );
  }
}
