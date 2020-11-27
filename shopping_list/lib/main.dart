import 'package:flutter/material.dart';
import 'package:shopping_list/u%C4%B1/shopping_list_page.dart';

void main() {
  runApp(ShoppingListApp());
}

class ShoppingListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:
          ThemeData(primarySwatch: Colors.green, backgroundColor: Colors.white),
      home: ShoppingListPage(),
    );
  }
}
