import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/models/review.dart';
import 'package:meals/providers/completed_provider.dart';
import 'package:meals/screens/meal_detail_screen.dart';

class CompletedScreen extends ConsumerWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAndReviews = ref.watch(completedProvider);

    var mealReviews = mealsAndReviews.isNotEmpty
        ? SingleChildScrollView(
            child: Column(
              children: [
                ...mealsAndReviews
                    .map((e) => MealReview(meal: e.$1, review: e.$2))
                    .toList()
              ],
            ),
          )
        : Center(
            heightFactor: 2,
            child: Text(
              'No completed meals yet.',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Completed meals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: mealReviews,
      ),
    );
  }
}

class MealReview extends ConsumerWidget {
  const MealReview({super.key, required this.meal, required this.review});
  final Meal meal;
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MealDetailScreen(meal: meal),
            ));
          },
          child: Container(
            width: double.infinity,
            // make it rounded by 5px
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).colorScheme.primary,
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(16),

            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      Row(
                        children: [
                          Text(
                            review.rating.str,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimary),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            review.rating.icon,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ref.read(completedProvider.notifier).removeReview(meal);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ))
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        )
      ],
    );
  }
}
