import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  Map<Filter, bool> _selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };



  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
        builder: (context) => FiltersScreen(currentFilters: _selectedFilters),
      ));
      if (result != null && result != _selectedFilters) {
        setState(() {
          _selectedFilters = result;
        });
      }
    }
  }

  get _filteredMeals {
    return ref.watch(mealsProvider).where((meal) {
      bool passesFilter = true;
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        passesFilter = false;
      } else if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        passesFilter = false;
      } else if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        passesFilter = false;
      } else if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        passesFilter = false;
      }
      return passesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      availableMeals: _filteredMeals,
    );
    String activeTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      final favouriteMeals = ref.watch(favouritesProvider);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activeTitle = 'Favourite meals';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
    );
  }
}
