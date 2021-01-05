import 'dart:async';
import 'dart:ui';

import 'package:badges/badges.dart';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_pojo.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/services/cart_service.dart';
import 'package:swift_flutter/utils/cart_item.dart';
import 'package:swift_flutter/utils/utils.dart';

class MealCard extends StatefulWidget {
  final MealPojo meal;
  final Function triggerState;

  MealCard(this.meal, {this.triggerState});

  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  CartService _cartService;

  @override
  Widget build(BuildContext context) {
    _cartService = Provider.of(context);
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onDoubleTap: () {
        showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            context: context,
            builder: (ctx) {
              CartItem _cart = _cartService.getCartItem(widget.meal);
              int _count = Utils.isNotNull(_cart) ? _cart.quantity : 1;
              return StatefulBuilder(builder: (BuildContext context, setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.42,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 190.0,
                        height: 190.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                              Utils.getImageUrl(widget.meal.image),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          widget.meal.name,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          '\₦ ${Utils.formatCurrency(widget.meal.price)}',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Resources.APP_PRIMARY_COLOR,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(14),
                              ),
                              onTap: () {
                                setState(() {
                                  _count = --_count < 1 ? 0 : _count;
                                });
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                left: 13,
                                right: 13,
                              ),
                              child: Text(
                                '$_count',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 23),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Resources.APP_PRIMARY_COLOR,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(14),
                              ),
                              onTap: () {
                                setState(() {
                                  _count = _count + 1;
                                });
                              },
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: RaisedButton.icon(
                                  color: Resources.APP_PRIMARY_COLOR,
                                  padding: EdgeInsets.all(14),
                                  onPressed: () {
                                    if (_count > 0) {
                                      setState(() {
                                        _cartService.addMeal(
                                            widget.meal, _count);
                                        widget.triggerState();
                                      });
                                    }else{
                                      setState(() {
                                        _cartService.removeMeal(widget.meal);
                                        widget.triggerState();
                                      });
                                    }
                                    Future.delayed(Duration(milliseconds: 100),
                                        () => Navigator.pop(context));
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Add to cart',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            });
      },
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              ),
              Center(
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    height: 430,
                    width: 430,
                    placeholder: Resources.SPINNER,
                    image: Utils.getImageUrl(widget.meal.image)),
              ),
              _cartService.itemExists(widget.meal)
                  ? Positioned(
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: Badge(
                          padding: EdgeInsets.all(4),
//                    position: BadgePosition(top: 4, start: 17),
                          badgeContent: Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                            size: 25,
                          ),
                          badgeColor: Resources.APP_PRIMARY_COLOR,
                          child: null,
                        ),
                      ),
                      top: 10,
                      right: 10,
                    )
                  : SizedBox(),
              Positioned(
                bottom: 0,
                child: Container(
                  width: (screenWidth - 38),
                  height: 120,
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Text(
                                widget.meal.name,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                softWrap: false,
                              )),
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  "\₦${Utils.formatCurrency(widget.meal.price)}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5, left: 10, right: 10, bottom: 10),
                          child: Row(
                            children: [
                              Flexible(
                                child: Text(
                                  widget.meal.description,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
         ),
    );
  }
}
