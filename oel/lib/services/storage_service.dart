import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const String _storageKey = 'student_tasks_v1';

  // Persists the task list to the device
  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> taskStrings = tasks.map((t) => t.toStorageString()).toList();
    await prefs.setStringList(_storageKey, taskStrings);
  }

  // Fetches saved tasks from the device
  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? taskStrings = prefs.getStringList(_storageKey);
    
    if (taskStrings == null) return [];
    return taskStrings.map((s) => Task.fromStorageString(s)).toList();
  }
}