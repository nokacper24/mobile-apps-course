import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/completed_provider.dart';
import 'package:meals/providers/favourites_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({
    super.key,
    required this.meal,
  });
  final Meal meal;

  void showSnackBar(WidgetRef ref, BuildContext context) {
    final bool wasAdded =
        ref.read(favouritesProvider.notifier).toggleMealFavouriteStatus(meal);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
            wasAdded ? 'Added to favourites!' : 'Removed from favourites.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isFavourite = ref.watch(favouritesProvider).contains(meal);

    var headerStyle = Theme.of(context).textTheme.titleLarge!.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.bold);

    var contentStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Theme.of(context).colorScheme.onBackground);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
              icon: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                        turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                        child: child);
                  },
                  child: Icon(
                    isFavourite ? Icons.star : Icons.star_border,
                    key: ValueKey(isFavourite),
                  )),
              onPressed: () {
                showSnackBar(ref, context);
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 300,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 14),
            Text('Ingredients', style: headerStyle),
            const SizedBox(height: 14),
            ...meal.ingredients.map((ingredient) {
              return Text(ingredient, style: contentStyle);
            }).toList(),
            const SizedBox(height: 14),
            Text('Steps', style: headerStyle),
            const SizedBox(height: 14),
            ...meal.steps
                .map(
                  (step) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      child: Text(step,
                          textAlign: TextAlign.center, style: contentStyle)),
                )
                .toList(),
            const SizedBox(height: 14),
            if (!isMealCompleted(meal, ref.watch(completedProvider)))
              ElevatedButton(
                child: const Text('Add a rating'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddReviewPopup(meal),
                  );
                },
              ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class AddReviewPopup extends ConsumerWidget {
  const AddReviewPopup(this.meal, {super.key});
  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: Text('Add a rating',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('How was your meal?',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground)),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...Rating.values.map((rating) {
                return ElevatedButton(
                    onPressed: () {
                      ref
                          .read(completedProvider.notifier)
                          .addReview(meal, rating);
                      Navigator.of(context).pop();
                    },
                    child: Text(rating.str));
              }).toList(),
            ],
          ),
          const SizedBox(height: 14),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
