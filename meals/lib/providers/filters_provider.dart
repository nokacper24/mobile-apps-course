import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool active) {
    state = {...state, filter: active};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

/// A provider that exposes the active filters.
/// Has a notifier that can be used to set the filters.
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    bool passesFilter = true;
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      passesFilter = false;
    } else if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      passesFilter = false;
    } else if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      passesFilter = false;
    } else if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      passesFilter = false;
    }
    return passesFilter;
  }).toList();
});
