import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemRow extends StatelessWidget {
  const GroceryItemRow(
      {super.key, required this.groceryItem, required this.onSwipe});
  final GroceryItem groceryItem;
  final Function() onSwipe;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(groceryItem.id),
      onDismissed: (direction) {
        onSwipe();
      },
      background: Container(
        height: double.infinity,
        width: double.infinity,
        color: Theme.of(context).colorScheme.error,
      ),
      child: ListTile(
        title: Text(groceryItem.name),
        leading: const Icon(Icons.square),
        iconColor: groceryItem.category.color,
        trailing: Text(groceryItem.quantity.toString()),
        leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
