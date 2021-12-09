import 'package:uuid/uuid.dart';

class TodoItem {
  Uuid id;
  String title;
  bool isCompleted;

  TodoItem({required this.id, required this.title, required this.isCompleted});
}
