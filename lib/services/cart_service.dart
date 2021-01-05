import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_API/model/meal_pojo.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'dart:convert';
import 'package:swift_flutter/utils/cart_item.dart';

class CartService {
  final BehaviorSubject<List<CartItem>> _subject =
      BehaviorSubject<List<CartItem>>();

  Future<List<CartItem>> initCart() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data =
        sharedPreferences.getString(Resources.SHARED_PREFERENCES_CART_ITEMS);

    if (data == null) {
      _subject.add([]);
      throw ('Not previous cart items');
    } else {
      List<CartItem> items = _decoder(data);
      _subject.add(items);
      return items;
    }
  }

  void removeMeal(MealPojo meal) {
    if (itemExists(meal)) {
      int index = getCartItems().indexWhere((i) => i.meal.id == meal.id);
      List<CartItem> items = getCartItems();
      items.removeAt(index);
      _subject.add(items);
      _saveItems();
    }
  }

  get listen$ {
    return _subject.stream.listen;
  }

  get stream{
    return _subject.stream;
  }

  void addMeal(MealPojo meal, int quantity) {
    List<CartItem> items = getCartItems();
    if (itemExists(meal)) {
      int index = items.indexWhere((i) => i.meal.id == meal.id);
      items[index].quantity = quantity;
    } else {
      items.add(_getCartItem(meal, quantity));
    }
    _subject.add(items);
    _saveItems();
  }

  void clearItems() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _subject.add([]);
    sharedPreferences.remove(Resources.SHARED_PREFERENCES_CART_ITEMS);
  }

  void _saveItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Resources.SHARED_PREFERENCES_CART_ITEMS, jsonEncode(_encoder(getCartItems())));
  }

  CartItem _getCartItem(MealPojo meal, int quantity) {
    return CartItem(meal: meal, quantity: quantity);
  }

  CartItem getCartItem(MealPojo meal){
    if(itemExists(meal)){
      return getCartItems().firstWhere((i) => i.meal.id == meal.id);
    }
    return null;
  }

  List<CartItem> getCartItems() {
    return _subject.value;
  }

  bool itemExists(MealPojo meal) {
    List<CartItem> items = getCartItems();
    if (items.isEmpty) return false;
    return items.map((e) => e.meal).contains(meal);
  }

  List<dynamic> _encoder(List<CartItem> items) {
    return items
        .map((i) => {
              "quantity": i.quantity,
              "meal": {
                "id": i.meal.id,
                "name": i.meal.name,
                "description": i.meal.description,
                "price": i.meal.price,
                "image": i.meal.image,
                "restaurantId": i.meal.restaurantId
              }
            })
        .toList();
  }

  List<CartItem> _decoder(String data) {
    List<dynamic> items = jsonDecode(data);
    return items.map((i) =>CartItem(meal: _getMealPojo(i['meal']), quantity: i['quantity'])).toList();
  }

  MealPojo _getMealPojo(Map<String, dynamic> meal) {
    return MealPojo((m) {
      m.restaurantId = meal['restaurantId'];
      m.image = meal['image'];
      m.price = meal['price'];
      m.description = meal['description'];
      m.name = meal['name'];
      m.id = meal['id'];
      return m.build();
    });
  }
}
