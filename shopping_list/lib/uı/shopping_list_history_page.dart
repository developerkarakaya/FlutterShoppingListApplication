import 'package:flutter/material.dart';

class ShoppingListHistoryPage extends StatefulWidget {
  @override
  _ShoppingListHistoryPageState createState() =>
      _ShoppingListHistoryPageState();
}

class _ShoppingListHistoryPageState extends State<ShoppingListHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text("Arşiv")),
        Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0),
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(title: Text(index.toString()));
                }))
      ],
    );
  }
}
