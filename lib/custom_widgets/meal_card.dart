import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class MealCard extends StatefulWidget {
  final String image;
  MealCard(this.image);
  @override
  _MealCard createState() => _MealCard();
}

class _MealCard extends State<MealCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        semanticContainer: true,
        child: Image.asset(
          widget.image,
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ));
  }
}
