import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category {
  food,
  travel,
  leasure,
  work,
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight,
  Category.leasure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.category,
    required this.amound,
    required this.date,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amound;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
