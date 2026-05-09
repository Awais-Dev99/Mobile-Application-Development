import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/storage_service.dart';
import '../widgets/task_tile.dart';
import 'add_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  bool _isLoading = true;

  // Real-time getters for the dashboard boxes
  int get notStartedCount => _tasks.where((t) => t.status == TaskStatus.notStarted).length;
  int get inProgressCount => _tasks.where((t) => t.status == TaskStatus.inProgress).length;
  int get completedCount => _tasks.where((t) => t.status == TaskStatus.completed).length;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await Future.delayed(const Duration(seconds: 2)); // Requirement 6 delay
    final loadedTasks = await StorageService.getTasks();
    if (mounted) {
      setState(() {
        _tasks = loadedTasks;
        _isLoading = false;
      });
    }
  }

  void _addNewTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
    StorageService.saveTasks(_tasks);
  }

  void _cycleTaskStatus(int index) {
    setState(() {
      final currentStatus = _tasks[index].status;
      if (currentStatus == TaskStatus.notStarted) {
        _tasks[index].status = TaskStatus.inProgress;
      } else if (currentStatus == TaskStatus.inProgress) {
        _tasks[index].status = TaskStatus.completed;
      } else {
        _tasks[index].status = TaskStatus.notStarted;
      }
    });
    StorageService.saveTasks(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Academic Task Manager")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildDashboard(),
                Expanded(
                  child: _tasks.isEmpty
                      ? const Center(child: Text("No tasks yet. Add one!"))
                      : ListView.builder(
                          itemCount: _tasks.length,
                          itemBuilder: (context, index) => TaskTile(
                            task: _tasks[index],
                            onToggle: () => _cycleTaskStatus(index),
                          ),
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
          if (result != null) _addNewTask(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDashboard() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          _statusBox("Pending", notStartedCount, Colors.orange),
          _statusBox("Doing", inProgressCount, Colors.blue),
          _statusBox("Done", completedCount, Colors.green),
        ],
      ),
    );
  }

  Widget _statusBox(String label, int count, Color color) {
    return Expanded(
      child: Card(
        elevation: 2,
        color: color.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Text(
                count.toString(),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
              ),
              Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}