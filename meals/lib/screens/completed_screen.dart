import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/review.dart';
import 'package:meals/providers/completed_provider.dart';

class CompletedScreen extends ConsumerWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAndReviews = ref.watch(completedProvider);

    var mealReviews = mealsAndReviews.length > 0
        ? Column(
            children: [
              ...mealsAndReviews
                  .map((e) => MealReview(meal: e.$1, review: e.$2))
                  .toList()
            ],
          )
        : const Text('No completed meals yet.');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed meals'),
      ),
      body: Column(
        children: [
          mealReviews,
        ],
      ),
    );
  }
}

class MealReview extends StatelessWidget {
  const MealReview({super.key, required this.meal, required this.review});
  final Meal meal;
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Card(
        child: Column(
          children: [
            Text(meal.title),
            Text(review.rating.toString()),
          ],
        ),
      ),
    );
  }
}
