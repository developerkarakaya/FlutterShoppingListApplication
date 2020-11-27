import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/item.dart';

class ConfirmDialog extends StatelessWidget {
  final Item item;

  const ConfirmDialog({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(item.name),
      content: Text("${item.name} Listeden silinsin mi?"),
      actions: [
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              "İptal",
              style: TextStyle(color: Colors.black),
            )),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            "Sil",
            style: TextStyle(color: Colors.white),
          ),
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
