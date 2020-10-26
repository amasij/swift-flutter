import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RestaurantCard extends StatefulWidget {
  final String image;
  RestaurantCard(this.image);
  @override
  _RestaurantCard createState() => _RestaurantCard();
}

class _RestaurantCard extends State<RestaurantCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              bottom: 0,
              child: Container(
                width: (screenWidth - 38),
                height: 88,
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
                              "Chicken Republic",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              softWrap: false,
                            )),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.pin_drop,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Text(
                                    "2.6km",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                "Beside AP plaza, Wuse 2 , Abuja",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Flexible(
                                child: RatingBar(
                              initialRating: 2.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

//            Flex(
//                  direction: Axis.horizontal,
//                  children: [
//                    Expanded(
//                        child: ConstrainedBox(
//                          constraints: BoxConstraints.loose(Size(100,100)),
//                          child: BackdropFilter(
//                            filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
//                            child: Container(
//                              color: Colors.black.withOpacity(0.3),
//                            ),
//                          ),
//                        ))
//                  ],
//                ),

//            ConstrainedBox(
//              constraints: BoxConstraints.expand(
//                width: double.infinity,
//                height: 50,
//              ),
//              child: BackdropFilter(
//                filter: ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2),
//                child: Container(
//                  color: Colors.black.withOpacity(0.3),
//                ),
//              ),
//            )
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ));
  }
}
