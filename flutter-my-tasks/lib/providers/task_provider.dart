import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../database/database_helper.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];
  String _filter = 'all';
  String _category = 'all';

  List<Task> get tasks => _filteredTasks;
  String get filter => _filter;
  String get category => _category;

  List<Task> get _filteredTasks {
    List<Task> filtered = _tasks;

    // Aplicar filtro de status
    switch (_filter) {
      case 'completed':
        filtered = filtered.where((t) => t.completed).toList();
        break;
      case 'pending':
        filtered = filtered.where((t) => !t.completed).toList();
        break;
      case 'important':
        filtered = filtered.where((t) => t.important).toList();
        break;
      default:
        break;
    }

    // Aplicar filtro de categoria
    if (_category != 'all') {
      filtered = filtered.where((t) => t.category == _category).toList();
    }

    return filtered;
  }

  Future<void> loadTasks() async {
    _tasks = await DatabaseHelper.instance.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String text, String category, String priority) async {
    final task = Task(
      id: const Uuid().v4(),
      text: text,
      category: category,
      priority: priority,
      createdAt: DateTime.now(),
    );
    await DatabaseHelper.instance.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    await loadTasks();
  }

  Future<void> deleteTask(String id) async {
    await DatabaseHelper.instance.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(String id) async {
    final task = _tasks.firstWhere((t) => t.id == id);
    final updated = task.copyWith(completed: !task.completed);
    await updateTask(updated);
  }

  Future<void> toggleTaskImportant(String id) async {
    final task = _tasks.firstWhere((t) => t.id == id);
    final updated = task.copyWith(important: !task.important);
    await updateTask(updated);
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void setCategory(String category) {
    _category = category;
    notifyListeners();
  }

  Map<String, int> getStats() {
    final total = _tasks.length;
    final completed = _tasks.where((t) => t.completed).length;
    final pending = total - completed;

    return {
      'total': total,
      'completed': completed,
      'pending': pending,
    };
  }

  Future<void> clearCompleted() async {
    final completed = _tasks.where((t) => t.completed).toList();
    for (var task in completed) {
      await DatabaseHelper.instance.deleteTask(task.id);
    }
    await loadTasks();
  }

  Future<void> clearAll() async {
    for (var task in _tasks) {
      await DatabaseHelper.instance.deleteTask(task.id);
    }
    await loadTasks();
  }
}
