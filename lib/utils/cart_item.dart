import 'package:flutter/cupertino.dart';
import 'package:swift_API/model/meal_pojo.dart';

class CartItem{
  final MealPojo meal;
  int quantity;
  CartItem({@required this.meal, @required this.quantity});
}