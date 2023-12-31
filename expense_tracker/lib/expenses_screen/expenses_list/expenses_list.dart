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
        var expenseItem = ExpenseItem(expense: expenses[index]);
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Dismissible(
                key: ValueKey(expenses[index]),
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
                dismissThresholds: const {
                  DismissDirection.endToStart:
                      0.4, // greater threshold for delete, avoid accidental delete
                  DismissDirection.startToEnd:
                      0.2, // smaller threshold for update
                },
                background: DismissableCardBackground(
                  // Edit background
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.75),
                  icon: Icons.draw,
                  direction: DismissDirection.startToEnd,
                  height: 82,
                ),
                secondaryBackground: DismissableCardBackground(
                  // Delete background
                  backgroundColor:
                      Theme.of(context).colorScheme.error.withOpacity(0.75),
                  icon: Icons.delete,
                  direction: DismissDirection.endToStart,
                  height: 82,
                ),
                child: expenseItem),
          ),
        );
      },
    );
  }
}

/// A background for a dismissable card.
/// It is better than the default background because it is not clipped.
/// [icon] is the icon to be displayed.
/// [backgroundColor] is the background color.
/// [iconAlignment] is the alignment of the icon.
/// [height] is the height of the background.
class DismissableCardBackground extends StatelessWidget {
  const DismissableCardBackground(
      {super.key,
      required this.icon,
      required this.backgroundColor,
      required this.direction,
      required this.height});
  final IconData icon;
  final Color backgroundColor;
  final DismissDirection direction;
  final double height;

  @override
  Widget build(BuildContext context) {
    var iconAlignment = direction == DismissDirection.startToEnd
        ? Alignment.centerLeft
        : Alignment.centerRight;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: height,
      color: backgroundColor,
      alignment: iconAlignment,
      child: Icon(icon),
    );
  }
}
