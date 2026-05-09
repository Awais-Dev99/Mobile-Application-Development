enum TaskStatus { notStarted, inProgress, completed }

class Task {
  String title;
  TaskStatus status;

  Task({required this.title, this.status = TaskStatus.notStarted});

  // Requirement 5: Converts Task and its status to a String for storage
  String toStorageString() {
    return '$title|${status.name}';
  }

  // Requirement 5: Reconstructs Task from a stored String
  factory Task.fromStorageString(String taskData) {
    final parts = taskData.split('|');
    return Task(
      title: parts[0],
      status: TaskStatus.values.byName(parts[1]),
    );
  }
}