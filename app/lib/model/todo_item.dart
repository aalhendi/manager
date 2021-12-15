const String tableTodos = 'todos';

class TodoItemFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String isCompleted = 'isCompleted';
  static const String createdAt = 'createdAt';
}

class TodoItem {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;

  TodoItem(
      {required this.id,
      required this.title,
      required this.isCompleted,
      required this.createdAt});

  // Convert a Todo into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      TodoItemFields.id: id,
      TodoItemFields.title: title,
      TodoItemFields.isCompleted: isCompleted ? 1 : 0,
      TodoItemFields.createdAt: createdAt.toIso8601String()
    };
  }

  static TodoItem fromMap(Map<String, Object?> map) => TodoItem(
        id: map[TodoItemFields.id] as String,
        title: map[TodoItemFields.title] as String,
        isCompleted: map[TodoItemFields.isCompleted] == 1,
        createdAt: DateTime.parse([TodoItemFields.createdAt] as String),
      );

  // Implement toString to make it easier to see information about
  // each todo when using the print statement.
  @override
  String toString() {
    return 'TodoItem{${TodoItemFields.id}: $id, ${TodoItemFields.title}: $title, ${TodoItemFields.isCompleted}: $isCompleted}';
  }
}
