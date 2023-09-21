import 'package:expense_tracker/expenses_screen/expenses_list/exoense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key,
      required this.expenses,
      required this.onRemoveExpense,
      required this.onUpdateExpense});

  final void Function(Expense) onRemoveExpense;

  final void Function({required Expense expenseToUpdate}) onUpdateExpense;

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
        dismissThresholds: const {
          DismissDirection.endToStart: 0.4,
          DismissDirection.startToEnd: 0.2,
        },
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          padding: const EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.draw),
        ),
        secondaryBackground: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          padding: const EdgeInsets.only(right: 5),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete),
        ),
        confirmDismiss: (direction) {
          if (direction == DismissDirection.endToStart) {
            return Future(() => true);
          } else {
            onUpdateExpense(expenseToUpdate: expenses[index]);
            return Future(() => false);
          }
        },
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            onRemoveExpense(expenses[index]);
          } else {
            //
          }
        },
        // direction: DismissDirection.endToStart,
        child: ExpenseItem(expense: expenses[index]),
      ),
    );
  }
}
