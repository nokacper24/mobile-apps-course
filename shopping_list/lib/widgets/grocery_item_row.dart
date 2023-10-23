import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemRow extends StatelessWidget {
  const GroceryItemRow({super.key, required this.groceryItem});
  final GroceryItem groceryItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(groceryItem.name),
      leading: const Icon(Icons.square),
      iconColor: groceryItem.category.color,
      trailing: Text(groceryItem.quantity.toString()),
      leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
