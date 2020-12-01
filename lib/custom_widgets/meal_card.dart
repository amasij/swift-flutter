import 'dart:async';
import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';

class MealCard extends StatefulWidget {
  final String image;
  MealCard(this.image);
  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onDoubleTap: () {
        showModalBottomSheet(
            context: context,
            builder: (ctx) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.42,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 190.0,
                      height: 190.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(widget.image))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        "PIZZA CONYATA",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Text(
                        "\₦6,700.00",
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
                              print("remove item");
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 13,
                              right: 13,
                            ),
                            child: Text(
                              "1",
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
                              print("add item");
                            },
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: RaisedButton.icon(
                                color: Resources.APP_PRIMARY_COLOR,
                                padding: EdgeInsets.all(14),
                                onPressed: () {},
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
      },
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          child: Stack(
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width: double.infinity,
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(right: 0),
                  child: Badge(
                    padding: EdgeInsets.all(3),
//                    position: BadgePosition(top: 4, start: 17),
                    badgeContent: Icon(Icons.shopping_cart,color: Colors.white,size: 20,),
                    child: null,
                  ),
                ),
                top: 10,
                right: 10,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: (screenWidth - 38),
                  height: 110,
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
                                "PIZZA CONYATA",
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
                                  "\₦6,700.00",
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
                                  "This is a very fresh and delicious pizza with very nice toppings",
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
    );
  }
}
