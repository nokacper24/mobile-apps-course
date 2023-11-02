import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/screens/new_item_screen.dart';
import 'package:shopping_list/widgets/grocery_item_row.dart';

const kAPIurl = ;

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<GroceryItem> _grocryItems = [];

  void _loadItems() async {
    final url = Uri.https(kAPIurl, 'shopping-list.json');
    final response = await http.get(url);
    final List<GroceryItem> loadedItemsList = [];
    final Map<String, dynamic> responseData = json.decode(response.body);

    for (final item in responseData.entries) {
      final category = categories.entries
          .firstWhere(
            (element) => element.value.title == item.value['category'],
          )
          .value;

      loadedItemsList.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    setState(() {
      _grocryItems = loadedItemsList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _addItem() async {
    // final GroceryItem? newItem =
    //     await Navigator.of(context).push<GroceryItem>(MaterialPageRoute(
    //   builder: (context) => const NewItemScreen(),
    // ));
    // if (newItem != null) {
    //   setState(() {
    //     _grocryItems.add(newItem);
    //   });
    // }
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const NewItemScreen(),
    ));

    _loadItems();
  }

  void _deleteItem(GroceryItem groceryItem) async {
    // setState(() {
    //   _grocryItems.remove(groceryItem);
    // });
    final url = Uri.https(kAPIurl, 'shopping-list/${groceryItem.id}.json');
    await http.delete(url);
    _loadItems();
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
