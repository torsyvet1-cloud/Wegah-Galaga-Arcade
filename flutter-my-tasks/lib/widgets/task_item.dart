import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleComplete;
  final VoidCallback onToggleImportant;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onToggleComplete,
    required this.onToggleImportant,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryEmoji = _getCategoryEmoji();
    final categoryLabel = _getCategoryLabel();
    final priorityColor = _getPriorityColor();

    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.grey[100]
          : Colors.grey[900],
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (_) => onToggleComplete(),
        ),
        title: Text(
          task.text,
          style: TextStyle(
            decoration: task.completed ? TextDecoration.lineThrough : null,
            color: task.completed
                ? Colors.grey[500]
                : Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: priorityColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '$categoryEmoji $categoryLabel',
                style: TextStyle(color: priorityColor, fontSize: 12),
              ),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 120,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  task.important ? Icons.star : Icons.star_outline,
                  color: task.important ? Colors.amber : Colors.grey,
                ),
                onPressed: onToggleImportant,
                iconSize: 20,
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: onEdit,
                iconSize: 20,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: onDelete,
                iconSize: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryEmoji() {
    const emojis = {
      'trabalho': '💼',
      'pessoal': '👤',
      'compras': '🛒',
      'saude': '🏥',
      'outros': '📌',
    };
    return emojis[task.category] ?? '📌';
  }

  String _getCategoryLabel() {
    const labels = {
      'trabalho': 'Trabalho',
      'pessoal': 'Pessoal',
      'compras': 'Compras',
      'saude': 'Saúde',
      'outros': 'Outros',
    };
    return labels[task.category] ?? 'Outros';
  }

  Color _getPriorityColor() {
    switch (task.priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
