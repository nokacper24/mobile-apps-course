import 'package:expense_tracker/expenses_screen/expenses_screen.dart';
import 'package:flutter/material.dart';

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ExpensesScreen(),
    );
  }
}
