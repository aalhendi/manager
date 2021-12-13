import 'package:uuid/uuid.dart';

class TodoItem {
  Uuid id;
  String title;
  bool isCompleted;

  TodoItem({required this.id, required this.title, required this.isCompleted});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'TodoItem{id: $id, title: $title, isCompleted: $isCompleted}';
  }
}
