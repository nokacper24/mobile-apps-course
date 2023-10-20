import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/filters_provider.dart';

/// A screen that allows the user to set filters for the meals.
class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: const Column(
        children: [
          FilterSwitchListTile(
            title: 'Gluten-free',
            subtitle: 'Only include gluten-free meals.',
            filter: Filter.glutenFree,
          ),
          FilterSwitchListTile(
            title: 'Lactose-free',
            subtitle: 'Only include lactose-free meals.',
            filter: Filter.lactoseFree,
          ),
          FilterSwitchListTile(
            title: 'Vegetarian',
            subtitle: 'Only include vegetarian meals.',
            filter: Filter.vegetarian,
          ),
          FilterSwitchListTile(
            title: 'Vegan',
            subtitle: 'Only include vegan meals.',
            filter: Filter.vegan,
          ),
        ],
      ),
    );
  }
}

/// A switch list tile that represents a filter that can be applied to meals.
class FilterSwitchListTile extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Filter filter;

  const FilterSwitchListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.filter,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var activeFilters = ref.watch(filtersProvider);
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 32, right: 22),
      value: activeFilters[filter]!,
      onChanged: (value) {
        ref.read(filtersProvider.notifier).setFilter(filter, value);
      },
    );
  }
}
