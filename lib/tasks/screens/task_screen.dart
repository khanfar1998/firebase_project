import 'package:firebase_project/auth/services/auth_service.dart';
import 'package:firebase_project/tasks/models/task_model.dart';
import 'package:firebase_project/tasks/screens/add_task_screen.dart';
import 'package:firebase_project/tasks/serivces/task_service.dart';
import 'package:flutter/material.dart';

import 'edit_task_screen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TaskService _taskService = TaskService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: StreamBuilder(
        stream: _taskService.getTasks(_authService.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading tasks'));
          }
          final tasks = snapshot.data ?? [];
          if (tasks.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              TaskModel task = tasks[index];
              return Card(
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.description),
                      Text('Due Date: ${task.dueDate}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Implement edit functionality
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditTaskScreen(task: task),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _taskService.deleteTask(task.id!);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
