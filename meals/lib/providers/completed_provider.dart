import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

enum Rating {
  poor(str: 'Poor', icon: Icons.sentiment_very_dissatisfied),
  average(str: 'Average', icon: Icons.sentiment_satisfied),
  excellent(str: 'Excellent', icon: Icons.sentiment_very_satisfied);

  final String str;
  final IconData icon;
  const Rating({required this.str, required this.icon});
}

class CompletedNotifier extends StateNotifier<List<(Meal, Rating)>> {
  CompletedNotifier() : super([]);

  void addReview(Meal meal, Rating rating) {
    state = [...state, (meal, rating)];
  }

  void removeReview(Meal meal) {
    state = state.where((element) => element.$1.id != meal.id).toList();
  }
}

bool isMealCompleted(Meal meal, List<(Meal, Rating)> completedMeals) {
  return completedMeals.any((element) => element.$1.id == meal.id);
}

final completedProvider =
    StateNotifierProvider<CompletedNotifier, List<(Meal, Rating)>>((ref) {
  return CompletedNotifier();
});
