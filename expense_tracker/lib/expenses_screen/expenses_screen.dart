import 'package:expense_tracker/expenses_screen/chart/chart.dart';
import 'package:expense_tracker/expenses_screen/expenses_list/expenses_list.dart';
import 'package:expense_tracker/expenses_screen/expenses_list/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = sampleExpenses;

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addNewExpense,
      ),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: _registeredExpenses.isNotEmpty
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                    child: ExpensesList(
                  expenses: _registeredExpenses,
                  onRemoveExpense: _removeExpense,
                )),
              ],
            )
          : const Center(child: Text('No expenses found. Start adding some!')),
    );
  }
}
