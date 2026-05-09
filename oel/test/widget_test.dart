import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:oel/main.dart'; // Ensure this matches your pubspec.yaml name

void main() {
  testWidgets('Task Manager smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const SmartTaskManagerApp());

    // Verify that our app bar title exists.
    expect(find.text('Daily Academic Tasks'), findsOneWidget);

    // Verify that the add button (FAB) is present.
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}