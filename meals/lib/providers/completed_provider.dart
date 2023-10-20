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

final completedProvider =
    StateNotifierProvider<CompletedNotifier, List<(Meal, Rating)>>((ref) {
  return CompletedNotifier();
});


final completedMealsProvider = Provider<List<Meal>>((ref) {
  return ref.watch(completedProvider).map((e) => e.$1).toList();
});