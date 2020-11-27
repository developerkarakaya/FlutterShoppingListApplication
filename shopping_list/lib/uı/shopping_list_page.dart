import 'package:flutter/material.dart';
import 'package:shopping_list/http/item_service.dart';
import 'package:shopping_list/model/item.dart';
import 'package:shopping_list/u%C4%B1/dialog/item_dialog.dart';
import 'package:shopping_list/u%C4%B1/shopping_list_history_page.dart';
import 'package:shopping_list/u%C4%B1/shopping_list_item_page.dart';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();
  ItemService _itemService;
  @override
  void initState() {
    _itemService = ItemService();
    _pageController.addListener(() {
      int currentIndex = _pageController.page.round();
      if (currentIndex != _selectedIndex) {
        _selectedIndex = currentIndex;
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String _itemName = await showDialog(
              context: context,
              builder: (BuildContext context) => ItemDialog());

          var item =
              Item(name: _itemName, isCompleted: false, isArchived: false);
          _itemService.addItem(item.toJson());
          setState(() {
            // set state metodunu cagırırsan widget build olur ve anlık olarak veri değişimi sağlayabilirsin **** ÖNEMLİ
          });
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: Text("Anasayfa")),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), title: Text("Alışveriş Listem")),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text("Arşiv"))
        ],
        currentIndex: _selectedIndex,
        onTap: _onTap,
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            child: Center(child: Text("Anasayfa")),
          ),
          ShoppingListItemPage(),
          ShoppingListHistoryPage()
        ],
      ),
    );
  }

  void _onTap(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}
