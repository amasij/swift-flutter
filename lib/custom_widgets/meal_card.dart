import 'dart:async';
import 'dart:ui';

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
        child: Stack(
          children: [
            Image.asset(
              widget.image,
              fit: BoxFit.fill,
              width: double.infinity,
            ),
            Positioned(
              top: 0,
              left: 0,
              width: 5000,
              height: 100,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 3),
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ));
  }
}
