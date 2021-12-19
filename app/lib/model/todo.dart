const String tableTodos = 'todos';

class TodoFields {
  static const String id = '_id';
  static const String title = 'title';
  static const String isCompleted = 'isCompleted';
  static const String createdAt = 'createdAt';
}

class Todo {
  String id;
  String title;
  bool isCompleted;
  DateTime createdAt;

  Todo(
      {required this.id,
      required this.title,
      required this.isCompleted,
      required this.createdAt});

  // Convert a Todo into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      TodoFields.id: id,
      TodoFields.title: title,
      TodoFields.isCompleted: isCompleted ? 1 : 0,
      TodoFields.createdAt: createdAt.toIso8601String()
    };
  }

  static Todo fromMap(Map<String, Object?> map) => Todo(
        id: map[TodoFields.id] as String,
        title: map[TodoFields.title] as String,
        isCompleted: map[TodoFields.isCompleted] == 1,
        createdAt: DateTime.parse([TodoFields.createdAt] as String),
      );

  // Implement toString to make it easier to see information about
  // each todo when using the print statement.
  @override
  String toString() {
    return 'Todo{${TodoFields.id}: $id, ${TodoFields.title}: $title, ${TodoFields.isCompleted}: $isCompleted}';
  }
}
