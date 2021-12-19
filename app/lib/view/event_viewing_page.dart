import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/model/event.dart';
import 'package:manager/utils/show_delete_dialog.dart';
import 'package:provider/provider.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;
  const EventViewingPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> buildActions() => [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              int index = context.read<EventNotifier>().getIndex(event.id);
              showDeleteDialog(context,
                  context.read<EventNotifier>().deleteEvent, index, event.id);
              // BUG: Pop navigator only if delete pressed
            },
            icon: const Icon(Icons.delete),
          ),
        ];
    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildActions(),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0), child: Text(event.title)),
    );
  }
}
