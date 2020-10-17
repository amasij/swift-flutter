import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swift_flutter/custom_widgets/meal_card.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {

  List<MealCard> cards = [
    MealCard(Resources.VIGAN_IMAGE),
    MealCard(Resources.BURGER_IMAGE),
    MealCard(Resources.PIZZA_IMAGE),
  ];


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return Column(
          children: <Widget>[
            ListTile(title: cards[index]),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
            )
          ],
        );
      },
    );
  }
}
