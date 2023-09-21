import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  // Create new expense
  const NewExpense({
    super.key,
    required this.onAddExpense,
  })  : onUpdateExpense = null,
        expenseToUpdate = null;

  // Update an existing expense
  const NewExpense.update(
      {super.key, required this.onUpdateExpense, required this.expenseToUpdate})
      : onAddExpense = null;

  final Function(Expense)? onAddExpense;

  final Function(
      {required Expense oldExpense,
      required Expense updatedExpense})? onUpdateExpense;
  final Expense? expenseToUpdate;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      selectedDate = date ?? selectedDate;
    });
  }

  void _submitExpenceData() {
    final double? amount = double.tryParse(_amountController.text);
    if (_titleController.text.trim().isEmpty || amount == null || amount <= 0) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Invalid Input!'),
            content: const Text('Please enter valid title and amount.'),
            icon: const Icon(Icons.error),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    } else {
      final Expense newExpense = Expense(
          title: _titleController.text.trim(),
          category: selectedCategory,
          amount: amount,
          date: selectedDate);

      Expense? expenseToUpdate = widget.expenseToUpdate;
      if (expenseToUpdate != null) {
        widget.onUpdateExpense!(
            oldExpense: expenseToUpdate, updatedExpense: newExpense);
      } else {
        widget.onAddExpense!(newExpense);
      }
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    // Fill fields with details of existinf expense if provided
    Expense? expenseToUpdate = widget.expenseToUpdate;
    if (expenseToUpdate != null) {
      _amountController.text = expenseToUpdate.amount.toString();
      _titleController.text = expenseToUpdate.title;
      selectedCategory = expenseToUpdate.category;
      selectedDate = expenseToUpdate.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        var cancelButton = TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'));

        var saveExpenseButton = ElevatedButton(
            onPressed: _submitExpenceData, child: const Text('Save Expense'));

        var titleTextField = TextField(
          maxLength: 50,
          keyboardType: TextInputType.text,
          controller: _titleController,
          decoration: const InputDecoration(label: Text('Title')),
        );

        var amountTextField = TextField(
            keyboardType: TextInputType.number,
            controller: _amountController,
            decoration:
                const InputDecoration(label: Text('Amount'), prefixText: '\$'));

        var dropdownCategorySelectionButton = DropdownButton(
          value: selectedCategory,
          items: Category.values
              .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item.name.toUpperCase(),
                  )))
              .toList(),
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(
              () {
                selectedCategory = value;
              },
            );
          },
        );

        var datePickerRow = Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(formatter.format(selectedDate)),
            IconButton(
              onPressed: _presentDatePicker,
              icon: const Icon(
                Icons.calendar_month,
              ),
            ),
          ],
        );

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600) // Large or landscape
                    ...[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: titleTextField),
                        const SizedBox(width: 24),
                        Expanded(child: amountTextField),
                      ],
                    ),
                    Row(
                      children: [
                        dropdownCategorySelectionButton,
                        Expanded(child: datePickerRow)
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Spacer(),
                        cancelButton,
                        saveExpenseButton,
                      ],
                    )
                  ] else // Portrait
                    ...[
                    titleTextField,
                    Row(
                      children: [
                        Expanded(child: amountTextField),
                        const SizedBox(width: 16),
                        Expanded(child: datePickerRow)
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        dropdownCategorySelectionButton,
                        const Spacer(),
                        cancelButton,
                        saveExpenseButton,
                      ],
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
