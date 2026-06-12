import 'package:flutter/material.dart';

class TaskFormDialog extends StatefulWidget {
  final Function(String text, String category, String priority) onSave;
  final Task? task;

  const TaskFormDialog({Key? key, required this.onSave, this.task})
      : super(key: key);

  @override
  State<TaskFormDialog> createState() => _TaskFormDialogState();
}

class _TaskFormDialogState extends State<TaskFormDialog> {
  late final TextEditingController _controller;
  late String _selectedCategory;
  late String _selectedPriority;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task?.text ?? '');
    _selectedCategory = widget.task?.category ?? 'outros';
    _selectedPriority = widget.task?.priority ?? 'low';
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Nova Tarefa' : 'Editar Tarefa'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Descrição da tarefa',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (value) =>
                  setState(() => _selectedCategory = value ?? 'outros'),
              items: const [
                DropdownMenuItem(value: 'trabalho', child: Text('💼 Trabalho')),
                DropdownMenuItem(value: 'pessoal', child: Text('👤 Pessoal')),
                DropdownMenuItem(value: 'compras', child: Text('🛒 Compras')),
                DropdownMenuItem(value: 'saude', child: Text('🏥 Saúde')),
                DropdownMenuItem(value: 'outros', child: Text('📌 Outros')),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Baixa'),
                    value: 'low',
                    groupValue: _selectedPriority,
                    onChanged: (value) =>
                        setState(() => _selectedPriority = value ?? 'low'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Média'),
                    value: 'medium',
                    groupValue: _selectedPriority,
                    onChanged: (value) =>
                        setState(() => _selectedPriority = value ?? 'low'),
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Alta'),
                    value: 'high',
                    groupValue: _selectedPriority,
                    onChanged: (value) =>
                        setState(() => _selectedPriority = value ?? 'low'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_controller.text.isNotEmpty) {
              widget.onSave(
                _controller.text,
                _selectedCategory,
                _selectedPriority,
              );
            }
          },
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}

// Dummy Task class for import
class Task {}
