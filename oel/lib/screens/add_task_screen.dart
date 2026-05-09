import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  // Requirement 3: Form Handling
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _submitForm() {
    // Requirement 3: Validation logic
    if (_formKey.currentState!.validate()) {
      // Requirement 2: Navigation (Navigator.pop)
      Navigator.pop(context, _taskController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Task")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column( // Requirement 1: Layout Widgets
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Task Details",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15), // Requirement 1: Spacing
              TextFormField(
                controller: _taskController,
                decoration: const InputDecoration(
                  labelText: "Task Name",
                  hintText: "e.g., Complete Flutter Lab",
                  prefixIcon: Icon(Icons.edit),
                ),
                // Requirement 3: Validation
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Task name cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _submitForm, // Requirement 2: Interaction
                icon: const Icon(Icons.save),
                label: const Text("Save Task"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}