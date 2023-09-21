import 'package:expense_tracker/expenses_screen/expenses_list/exoense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

/// A list of expenses.
class ExpensesList extends StatelessWidget {
  /// Creates an ExpensesList widget.
  ///
  /// [expenses] will be displayed in the list.
  /// [onRemoveExpense] will be called when an expense is removed.
  /// [onUpdateExpense] will be called when an expense is to be updated.
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
      itemBuilder: (context, index) {
        var background = Container(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          padding: const EdgeInsets.only(left: 5),
          alignment: Alignment.centerLeft,
          child: const Icon(Icons.draw),
        );

        var secondaryBackground = Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
          padding: const EdgeInsets.only(right: 5),
          alignment: Alignment.centerRight,
          child: const Icon(Icons.delete),
        );

        return Dismissible(
          dismissThresholds: const {
            DismissDirection.endToStart:
                0.4, // greater threshold for delete, avoid accidental delete
            DismissDirection.startToEnd: 0.2, // smaller threshold for update
          },
          key: ValueKey(expenses[index]),
          background: background,
          secondaryBackground: secondaryBackground,
          confirmDismiss: (direction) {
            if (direction == DismissDirection.endToStart) {
              // delete -> dismiss
              return Future(() => true);
            } else {
              // update -> request update and do NOT dismiss
              onUpdateExpense(expenseToUpdate: expenses[index]);
              return Future(() => false);
            }
          },
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              onRemoveExpense(expenses[index]);
            } else {
              // will never be called, dismiss rejected, see `confirmDismiss` above
            }
          },
          child: ExpenseItem(expense: expenses[index]),
        );
      },
    );
  }
}
