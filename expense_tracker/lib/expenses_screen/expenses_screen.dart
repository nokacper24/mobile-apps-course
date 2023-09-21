import 'package:expense_tracker/expenses_screen/chart/chart.dart';
import 'package:expense_tracker/expenses_screen/expenses_list/expenses_list.dart';
import 'package:expense_tracker/expenses_screen/expenses_list/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

/// The main screen of the application.
/// Displays a list of expenses and a chart.
class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() {
    return _ExpensesScreenState();
  }
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = sampleExpenses;

  /// Opens the overlay to add a new expense.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(
        onAddExpense: _addNewExpense,
      ),
    );
  }

  /// Adds a new expense to the list of registered expenses.
  ///
  /// [expense] will be added to [_registeredExpenses].
  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// Removes an expense from the list of registered expenses.
  /// Displays a snackbar to undo the deletion.
  ///
  /// [expense] will be removed from [_registeredExpenses].
  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Expense deleted'),
      duration: const Duration(seconds: 20),
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

  /// Updates an expense in the list of registered expenses.
  ///
  /// [oldExpense] will be replaced by [updatedExpense] in [_registeredExpenses].
  void _updateExpense(
      {required Expense oldExpense, required Expense updatedExpense}) {
    setState(() {
      _registeredExpenses[_registeredExpenses.indexOf(oldExpense)] =
          updatedExpense;
    });
  }

  /// Opens the overlay to update an existing expense.
  ///
  /// [expenseToUpdate] is the expense that will be updated.
  void _openUpdateExpenseOverlay({required Expense expenseToUpdate}) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense.update(
        onUpdateExpense: _updateExpense,
        expenseToUpdate: expenseToUpdate,
      ),
    );
    //
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final mainContent = _registeredExpenses.isNotEmpty
        ? ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpense,
            onUpdateExpense: _openUpdateExpenseOverlay,
          )
        : const Center(child: Text('No expenses found. Start adding some!'));

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // fixes chart being moved by keyboard and overflowing
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: width < 600 // landscape mode
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            ) // portrait mode
          : Row(
              children: [
                Expanded(
                  child: Chart(
                    expenses: _registeredExpenses,
                  ),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}
