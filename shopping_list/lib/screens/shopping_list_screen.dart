import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';
import 'package:shopping_list/widgets/grocery_item_row.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<GroceryItem> _grocryItems = [];

  void _addItem() async {
    final GroceryItem? newItem =
        await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
      builder: (context) => const NewItemScreen(),
    ));
    if (newItem != null) {
      setState(() {
        _grocryItems.add(newItem);
      });
    }
  }

  void _deleteItem(GroceryItem groceryItem) {
    setState(() {
      _grocryItems.remove(groceryItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_grocryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _grocryItems.length,
        itemBuilder: (context, index) {
          GroceryItem item = _grocryItems[index];
          return GroceryItemRow(
            groceryItem: item,
            onSwipe: () {
              _deleteItem(item);
            },
          );
        },
      );
    } else {
      content = const Center(
        child: Text('You\'ve got no items yet.'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addItem,
          )
        ],
      ),
      body: content,
    );
  }
}
