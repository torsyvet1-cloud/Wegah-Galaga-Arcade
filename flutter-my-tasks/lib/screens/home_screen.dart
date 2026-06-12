import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/task_form.dart';
import '../widgets/stat_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📋 My Tasks'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: _showMenu,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Input Section
            _buildInputSection(),
            const SizedBox(height: 24),

            // Stats
            _buildStatsSection(),
            const SizedBox(height: 24),

            // Filters
            _buildFilterSection(),
            const SizedBox(height: 24),

            // Tasks List
            _buildTasksList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildInputSection() {
    return Card(
      elevation: 0,
      color: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Adicione uma nova tarefa...',
                prefixIcon: const Icon(Icons.task),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () => _showAddTaskDialog(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsSection() {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final stats = provider.getStats();
        return Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.assignment,
                label: 'Total',
                value: stats['total']!.toString(),
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.check_circle,
                label: 'Concluídas',
                value: stats['completed']!.toString(),
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.hourglass_empty,
                label: 'Pendentes',
                value: stats['pending']!.toString(),
                color: Colors.orange,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterSection() {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterButton(context, 'Todas', 'all', provider),
                  const SizedBox(width: 8),
                  _buildFilterButton(context, 'Pendentes', 'pending', provider),
                  const SizedBox(width: 8),
                  _buildFilterButton(context, 'Concluídas', 'completed', provider),
                  const SizedBox(width: 8),
                  _buildFilterButton(context, 'Importantes', 'important', provider),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String label,
    String filter,
    TaskProvider provider,
  ) {
    final isActive = provider.filter == filter;
    return ElevatedButton(
      onPressed: () => provider.setFilter(filter),
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? null : Colors.grey[300],
        foregroundColor: isActive ? Colors.white : Colors.black,
      ),
      child: Text(label),
    );
  }

  Widget _buildTasksList() {
    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        final tasks = provider.tasks;

        if (tasks.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Icon(
                    Icons.task,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma tarefa encontrada',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: tasks.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return TaskItem(
              task: tasks[index],
              onToggleComplete: () =>
                  provider.toggleTaskCompletion(tasks[index].id),
              onToggleImportant: () =>
                  provider.toggleTaskImportant(tasks[index].id),
              onEdit: () => _showEditTaskDialog(context, tasks[index]),
              onDelete: () => _deleteTask(context, provider, tasks[index]),
            );
          },
        );
      },
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => TaskFormDialog(
        onSave: (text, category, priority) {
          Provider.of<TaskProvider>(context, listen: false)
              .addTask(text, category, priority);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showEditTaskDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => TaskFormDialog(
        task: task,
        onSave: (text, category, priority) {
          final updated = task.copyWith(
            text: text,
            category: category,
            priority: priority,
          );
          Provider.of<TaskProvider>(context, listen: false)
              .updateTask(updated);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _deleteTask(BuildContext context, TaskProvider provider, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deletar Tarefa'),
        content: const Text('Tem certeza que deseja deletar esta tarefa?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.deleteTask(task.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Deletar'),
          ),
        ],
      ),
    );
  }

  void _showMenu() {
    final provider = Provider.of<TaskProvider>(context, listen: false);
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('Limpar Concluídas'),
            onTap: () {
              provider.clearCompleted();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever),
            title: const Text('Limpar Tudo'),
            textColor: Colors.red,
            iconColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Limpar Tudo'),
                  content: const Text(
                    'Tem certeza que deseja deletar TODAS as tarefas?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        provider.clearAll();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Deletar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
