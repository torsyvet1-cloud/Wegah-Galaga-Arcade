class Task {
  final String id;
  final String text;
  final String category;
  final String priority;
  final bool completed;
  final bool important;
  final DateTime createdAt;
  final DateTime? dueDate;

  Task({
    required this.id,
    required this.text,
    required this.category,
    required this.priority,
    this.completed = false,
    this.important = false,
    required this.createdAt,
    this.dueDate,
  });

  Task copyWith({
    String? id,
    String? text,
    String? category,
    String? priority,
    bool? completed,
    bool? important,
    DateTime? createdAt,
    DateTime? dueDate,
  }) {
    return Task(
      id: id ?? this.id,
      text: text ?? this.text,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
      important: important ?? this.important,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'category': category,
      'priority': priority,
      'completed': completed ? 1 : 0,
      'important': important ? 1 : 0,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      text: map['text'] ?? '',
      category: map['category'] ?? 'outros',
      priority: map['priority'] ?? 'low',
      completed: map['completed'] == 1,
      important: map['important'] == 1,
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      dueDate: map['dueDate'] != null ? DateTime.parse(map['dueDate']) : null,
    );
  }
}
