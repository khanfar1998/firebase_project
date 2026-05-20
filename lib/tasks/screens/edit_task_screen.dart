import 'package:firebase_project/auth/services/auth_service.dart';
import 'package:firebase_project/tasks/models/task_model.dart';
import 'package:firebase_project/tasks/serivces/task_service.dart';
import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  TaskModel task;
  EditTaskScreen({super.key, required this.task});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TaskService _taskService = TaskService();
  final AuthService _authService = AuthService();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.task.title;
    _descriptionController.text = widget.task.description;
    _selectedDate = widget.task.dueDate;
  }

  Future<void> pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextButton(
              onPressed: () => pickDueDate(context),
              child: const Text('Select Due Date'),
            ),
            Text('Selected Date: ${_selectedDate}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                TaskModel newTask = TaskModel(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  dueDate: _selectedDate,
                  userId: _authService.currentUser!.uid,
                );
                await _taskService.updateTask(widget.task.id!, newTask);
                Navigator.pop(context);
              },
              child: const Text('Update Task'),
            ),
          ],
        ),
      ),
    );
  }
}
