import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final Function(Expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category selectedCategory = Category.leisure;

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
      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            keyboardType: TextInputType.text,
            controller: _titleController,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: const InputDecoration(
                      label: Text('Amount'), prefixText: '\$'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
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
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
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
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenceData,
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
