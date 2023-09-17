import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    return expenses
        .map((e) => e.amount)
        .fold(0.0, (previousValue, element) => previousValue + element);
  }
}

List<Expense> get sampleExpenses {
  return [
    Expense(
      title: 'Restaurant',
      category: Category.food,
      amount: 120,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Cinema',
      category: Category.leisure,
      amount: 20,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Restaurant',
      category: Category.travel,
      amount: 120,
      date: DateTime.now(),
    ),
    Expense(
      title: 'Cinema',
      category: Category.work,
      amount: 20,
      date: DateTime.now(),
    ),
  ];
}
