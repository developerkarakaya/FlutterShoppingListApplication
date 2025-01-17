import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/item.dart';

import 'dialog/confirm_dialog.dart';

class ShoppingListItemPage extends StatefulWidget {
  @override
  _ShoppingListItemPageState createState() => _ShoppingListItemPageState();
}

class _ShoppingListItemPageState extends State<ShoppingListItemPage> {
  ItemService _itemService;

  @override
  void initState() {
    _itemService = ItemService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          title: Text("Alışveriş Listesi"),
          actions: [
            IconButton(
                icon: Icon(Icons.done_all),
                onPressed: () async {
                  await _itemService.addToArchive();
                  setState(() {});
                })
          ],
        ),
        Expanded(
          child: FutureBuilder(
              future: _itemService.fetchItems(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
                if (snapshot.hasData && snapshot.data.length == 0) {
                  return Center(
                    child: Text("Alışveriş listesinde ürün bulunmamaktadır."),
                  );
                }

                if (snapshot.hasData) {
                  return ListView.builder(
                    padding: EdgeInsets.all(0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      Item item = snapshot.data[index];
                      return GestureDetector(
                        onLongPress: () async {
                          bool result = await showDialog(
                              context: context,
                              builder: (BuildContext context) => ConfirmDialog(
                                    item: item,
                                  ));
                          item.isArchived = result;
                          await _itemService.editItem(item);
                          setState(() {});
                        },
                        child: CheckboxListTile(
                          title: Text(item.name),
                          onChanged: (bool value) async {
                            item.isCompleted = !item.isCompleted;
                            await _itemService.editItem(item);
                            setState(() {});
                          },
                          value: item.isCompleted,
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return Text(snapshot.hasError.toString());
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ],
    );
  }
}
