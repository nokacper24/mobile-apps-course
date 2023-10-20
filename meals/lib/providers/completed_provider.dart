import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/review.dart';

class CompletedNotifier extends StateNotifier<List<(Meal, Review)>> {
  CompletedNotifier() : super([]);

  void addReview(Meal meal, Review review) {
    state = [...state, (meal, review)];
  }

  void removeReview(Meal meal) {
    state = state.where((element) => element.$1.id != meal.id).toList();
  }
}

bool isMealCompleted(Meal meal, List<(Meal, Review)> completedMeals) {
  return completedMeals.any((element) => element.$1.id == meal.id);
}

final completedProvider =
    StateNotifierProvider<CompletedNotifier, List<(Meal, Review)>>((ref) {
  return CompletedNotifier();
});
