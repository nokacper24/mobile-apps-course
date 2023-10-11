import 'package:flutter/material.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';
import 'package:meals/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavourite,
      required this.availableMeals});
  final Function(Meal) onToggleFavourite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    List<Meal> meals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsScreen(
            title: category.title,
            meals: meals,
            onToggleFavourite: (meal) {
              onToggleFavourite(meal);
            },
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: availableCategories
          .map((category) => CategoryGridItem(
                category: category,
                onSelectCategory: () {
                  _selectCategory(context, category);
                },
              ))
          .toList(),
    );
  }
}