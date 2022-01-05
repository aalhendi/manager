import 'package:flutter/material.dart';
import 'package:manager/controller/event_notifier.dart';
import 'package:manager/controller/theme_notifier.dart';
import 'package:manager/model/event.dart';
import 'package:manager/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;
  const EventEditingPage({Key? key, this.event}) : super(key: key);

  @override
  _EventEditingPageState createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  late bool isAllDay;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now().add(const Duration(hours: 1));
      isAllDay = false;
    } else {
      final event = widget.event!;
      titleController.text = event.title;
      descriptionController.text = event.description;
      isAllDay = event.isAllDay;
      fromDate = event.from;
      toDate = event.to;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future saveForm() async {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        // TODO: Add UI for color

        final isEditing = widget.event != null;
        final provider = Provider.of<EventNotifier>(context, listen: false);

        final event = Event(
            id: isEditing ? widget.event!.id : const Uuid().v4(),
            title: titleController.text,
            description: descriptionController.text,
            from: fromDate,
            to: toDate,
            isAllDay: isAllDay,
            createdAt: DateTime.now());

        if (isEditing) {
          provider.updateEvent(event, provider.getIndex(event.id));
        } else {
          provider.addEvent(event);
        }

        Navigator.of(context).pop();
      }
    }

    List<Widget> buildEditingActions() => [
          ElevatedButton.icon(
            onPressed: saveForm,
            icon: const Icon(Icons.done),
            label: const Text("SAVE"),
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
          ),
        ];
    Widget buildTitle() => TextFormField(
          style: const TextStyle(fontSize: 24),
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), hintText: 'Add Title'),
          controller: titleController,
          validator: (title) =>
              title != null && title.isEmpty ? "Title cannot be empty" : null,
          onFieldSubmitted: (_) => {},
        );
    Widget buildDropdownField(
            {required String text, required VoidCallback onClicked}) =>
        ListTile(
          title: Text(text),
          trailing: const Icon(Icons.arrow_drop_down),
          onTap: onClicked,
        );
    Widget buildHeader({required String header, required Widget child}) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              header,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child
          ],
        );
    Future<DateTime?> pickDateTime(
      DateTime initialDate, {
      required bool pickDate,
      DateTime? firstDate,
    }) async {
      if (pickDate) {
        final date = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate ?? DateTime(1971),
            lastDate: DateTime(2100));
        if (date == null) {
          return null;
        }
        final time =
            Duration(hours: initialDate.hour, minutes: initialDate.minute);
        return date.add(time);
      } else {
        final timeOfDay = await showTimePicker(
            context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
        if (timeOfDay == null) {
          return null;
        }
        final date =
            DateTime(initialDate.year, initialDate.month, initialDate.day);
        final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
        return date.add(time);
      }
    }

    Future pickFromDateTime({required bool pickDate}) async {
      final date = await pickDateTime(fromDate, pickDate: pickDate);
      if (date == null) {
        return;
      }

      if (date.isAfter(toDate)) {
        toDate = date.add(const Duration(hours: 1));
      }

      setState(() {
        fromDate = date;
      });
    }

    Future pickToDateTime({required bool pickDate}) async {
      final date = await pickDateTime(toDate,
          pickDate: pickDate, firstDate: pickDate ? fromDate : null);
      if (date == null) {
        return;
      }

      setState(() {
        toDate = date;
      });
    }

    Widget buildFrom() => buildHeader(
          header: "FROM",
          child: Row(
            children: [
              Expanded(
                flex: 2, // Assigns 2/3 of the row space to this widget
                child: buildDropdownField(
                  text: Utils.toDate(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: true),
                ),
              ),
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
                ),
              )
            ],
          ),
        );
    Widget buildTo() => buildHeader(
          header: "TO",
          child: Row(
            children: [
              Expanded(
                flex: 2, // Assigns 2/3 of the row space to this widget
                child: buildDropdownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDateTime(pickDate: true),
                ),
              ),
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(toDate),
                  onClicked: () => pickToDateTime(pickDate: false),
                ),
              )
            ],
          ),
        );
    Widget buildDateTimePickers() => Column(
          children: <Widget>[buildFrom(), buildTo()],
        );
    Widget buildIsAllDay() {
      final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
      return Row(
        children: [
          Row(
            children: [
              Icon(
                Icons.watch_later,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                child: Text(
                  "All-Day?",
                  style: TextStyle(
                      fontSize: 16,
                      color: themeNotifier.themeData.colorScheme.onPrimary),
                ),
              ),
            ],
          ),
          Switch.adaptive(
              value: isAllDay,
              onChanged: (value) {
                setState(() {
                  isAllDay = value;
                });
              })
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    }

    Widget buildDescription() => TextFormField(
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
              border: OutlineInputBorder(), hintText: 'Add a description'),
          controller: descriptionController,
          validator: (description) =>
              description != null && description.length > 250
                  ? "Description cannot be longer than 250 characters"
                  : null,
          onFieldSubmitted: (_) => {},
          maxLines: 6,
          keyboardType: TextInputType.multiline,
        );

    return Scaffold(
      appBar: AppBar(
        leading: const CloseButton(),
        actions: buildEditingActions(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              buildTitle(),
              const SizedBox(
                height: 12,
              ),
              buildDateTimePickers(),
              buildIsAllDay(),
              const SizedBox(
                height: 12,
              ),
              buildDescription()
            ],
          ),
        ),
      ),
    );
  }
}
