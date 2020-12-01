import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swift_flutter/custom_widgets/meal_card.dart';
import 'package:swift_flutter/custom_widgets/restaurant_card.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {
  List<MealCard> mealCards = [
    MealCard(Resources.VIGAN_IMAGE),
    MealCard(Resources.BURGER_IMAGE),
    MealCard(Resources.PIZZA_IMAGE),
    MealCard(Resources.BURGER_IMAGE),
    MealCard(Resources.VIGAN_IMAGE),
    MealCard(Resources.PIZZA_IMAGE),
    MealCard(Resources.VIGAN_IMAGE),
    MealCard(Resources.BURGER_IMAGE),
  ];

  List<RestaurantCard> restaurantCards = [
    RestaurantCard(Resources.RESTAURANT_IMAGE_3),
    RestaurantCard(Resources.RESTAURANT_IMAGE_1),
    RestaurantCard(Resources.RESTAURANT_IMAGE_2)
  ];

  Map<String, Map<String, dynamic>> filterChips = {
    "FOOD": {
      'value': true,
      'label': 'Food',
      'icon': Icon(
        Icons.fastfood,
        color: Colors.white,
      ),
    },
    "DRINK": {
      'value': true,
      'label': 'Drinks',
      'icon': Icon(
        Icons.local_drink,
        color: Colors.white,
      ),
    },
    "RESTAURANT": {
      'value': false,
      'label': 'Restaurants',
      'icon': Icon(
        Icons.restaurant,
        color: Colors.white,
      ),
    },
  };
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: filterChips.keys.toList().map((e) {
              String key = e;
              return FilterChip(
                label: Text(
                  filterChips[key]['label'],
                  style: TextStyle(color: Colors.white),
                ),
                onSelected: (v) {
                  setState(() {
                    filterChips[key]['value'] = !filterChips[key]['value'];
                  });
                },
                selectedColor: Resources.APP_PRIMARY_COLOR,
                padding: EdgeInsets.only(top: 4, left: 7, right: 7, bottom: 4),
                selected: filterChips[key]['value'],
                showCheckmark: false,
                avatar: filterChips[key]['icon'],
              );
            }).toList(),
          ),
//
        ),
        Expanded(
          child: ListView.builder(
            itemCount: mealCards.length,
            itemBuilder: (context, index) {
              return index % 5 != 0
                  ? Column(
                      children: <Widget>[
                        ListTile(title: mealCards[index]),
                        Padding(
                          padding: EdgeInsets.only(bottom: 50),
                        )
                      ],
                    )
                  : Container(
                height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: restaurantCards.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 10, bottom: 10,right: 10),
                              height: 250,
                              width: 370,
                              child: restaurantCards[index],
                            );
                          }),
                    );
            },
          ),
        ),
      ],
    );
  }
}
