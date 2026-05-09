import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() async {
  // CRITICAL: Ensures native plugin bindings (like SharedPreferences) are 
  // ready before the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(const SmartTaskManagerApp());
}

class SmartTaskManagerApp extends StatelessWidget {
  const SmartTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Student Task Manager',
      debugShowCheckedModeBanner: false,
      
      // Requirement 1: Modern Material 3 Theme with Indigo Seed
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        
        // Consistent component styling across the app
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[50],
        ),
      ),

      // Requirement 2: Entry point for the application
      home: const HomeScreen(),
    );
  }
}