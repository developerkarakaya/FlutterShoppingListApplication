import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:shopping_list/model/item.dart';

class ItemService {
  final serviceUrl = "https://kesali-shopping.herokuapp.com/item";

  Future<List<Item>> fetchItems() async {
    final response = await http.get(serviceUrl);

    if (response.statusCode == 200) {
      Iterable items = json.decode(response.body);
      return items.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception("Servis ile bağlantı kurulurken bir hata oluştu.");
    }
  }

  Future<Item> addItem(String itemJson) async {
    final response = await http.post(serviceUrl,
        headers: {'content-type': 'application/json'}, body: itemJson);
    if (response.statusCode == 201) {
      Map item = json.decode(response.body);
      return Item.fromJson(item);
    } else {
      throw Exception("Servise veri kaydedilirken hata oluştu.");
    }
  }

  Future<Item> editItem(Item item) async {
    final response = await http.patch('$serviceUrl/${item.id}',
        headers: {'content-type': 'application/json'}, body: item.toJson());
    if (response.statusCode == 200) {
      Map item = json.decode(response.body);
      return Item.fromJson(item);
    } else {
      throw Exception("Servise veri kaydedilirken hata oluştu.");
    }
  }

  Future<Item> deleteItem(Item item) async {
    final response = await http.delete(
      '$serviceUrl/${item.id}',
      headers: {'content-type': 'application/json'},
    );
    if (response.statusCode == 200) {
      Map item = json.decode(response.body);
      return Item.fromJson(item);
    } else {
      throw Exception("Servise veri kaydedilirken hata oluştu.");
    }
  }

  Future<void> addToArchive() async {
    final response =
        await http.post("https://kesali-shopping.herokuapp.com/history");
    if (response.statusCode != 201) {
      throw Exception("Serviste Arşive veri eklenirken hata oluştu.");
    }
  }

  Future<List<Item>> fetchArchive(int take, int skip) async {
    var paramaters = {'take': take.toString(), 'skip': skip.toString()};

    var uri = Uri.https("kesali-shopping.herokuapp.com", "history", paramaters);
    final response = await http.get(uri);
  }
}
