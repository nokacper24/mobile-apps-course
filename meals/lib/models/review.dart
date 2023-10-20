import 'package:flutter/material.dart';

class Review {
  final String id;
  final Rating rating;

  Review({required this.id, required this.rating});
}

enum Rating {
  poor(str: 'Poor', icon: Icons.sentiment_very_dissatisfied),
  average(str: 'Average', icon: Icons.sentiment_satisfied),
  excellent(str: 'Excellent', icon: Icons.sentiment_very_satisfied);

  final String str;
  final IconData icon;
  const Rating({required this.str, required this.icon});
}
