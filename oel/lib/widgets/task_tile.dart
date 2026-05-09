import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onToggle;

  const TaskTile({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color color;

    switch (task.status) {
      case TaskStatus.notStarted:
        icon = Icons.radio_button_unchecked;
        color = Colors.orange;
        break;
      case TaskStatus.inProgress:
        icon = Icons.pending_actions;
        color = Colors.blue;
        break;
      case TaskStatus.completed:
        icon = Icons.check_circle;
        color = Colors.green;
        break;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.status == TaskStatus.completed ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(task.status.name.toUpperCase(), style: TextStyle(fontSize: 10, color: color)),
        trailing: const Icon(Icons.sync, size: 16, color: Colors.grey),
        onTap: onToggle,
      ),
    );
  }
}