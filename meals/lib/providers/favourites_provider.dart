import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavouritesNotifier extends StateNotifier<List<Meal>> {
  FavouritesNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    bool removed = false;
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      removed = true;
    } else {
      state = [...state, meal];
    }
    return !removed;
  }
}

/// A provider that exposes the list of favourite meals.
final favouritesProvider =
    StateNotifierProvider<FavouritesNotifier, List<Meal>>((ref) {
  return FavouritesNotifier();
});
