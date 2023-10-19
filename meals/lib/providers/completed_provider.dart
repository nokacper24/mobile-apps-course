import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/review.dart';

class CompletedNotifier extends StateNotifier<List<(Meal, Review)>> {
  CompletedNotifier() : super([dummy_tuple, dummy_tuple]);

  void addReview(Meal meal, Review review) {
    state = [...state, (meal, review)];
  }

  void removeReview(Meal meal) {
    state = state.where((element) => element.$1.id != meal.id).toList();
  }
}

final completedProvider =
    StateNotifierProvider<CompletedNotifier, List<(Meal, Review)>>((ref) {
  return CompletedNotifier();
});

final dummy_tuple = (
  const Meal(
    id: 'm1',
    categories: [
      'c1',
      'c2',
    ],
    title: 'Spaghetti with Tomato Sauce',
    affordability: Affordability.affordable,
    complexity: Complexity.simple,
    imageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    duration: 20,
    ingredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    steps: [
      'Cut the tomatoes and the onion into small pieces.',
      'Boil some water - add salt to it once it boils.',
      'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
      'In the meantime, heaten up some olive oil and add the cut onion.',
      'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
      'The sauce will be done once the spaghetti are.',
      'Feel free to add some cheese on top of the finished dish.'
    ],
    isGlutenFree: false,
    isVegan: true,
    isVegetarian: true,
    isLactoseFree: true,
  ),
  Review(
    id: 'r1',
    rating: Rating.average,
  ),
);
