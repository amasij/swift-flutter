import 'dart:async';

import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_filter.dart';
import 'package:swift_API/model/meal_pojo.dart';
import 'package:swift_API/model/query_results_meal_pojo.dart';
import 'package:swift_flutter/custom_widgets/error_response_modal.dart';
import 'package:swift_flutter/custom_widgets/meal_card.dart';
import 'package:swift_flutter/custom_widgets/restaurant_card.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/feed_service.dart';
import 'package:swift_flutter/services/user_service.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> {


  FeedService _feedService = new FeedService();
  SwiftAPI _swiftAPI;
  UserService _userService;
  int limit = 10;
  int offset = 0;
  List<MealPojo> meals = [];


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
  void initState() {
    _swiftAPI = Provider.of<SwiftAPI>(context, listen: false);
    _userService = Provider.of<UserService>(context, listen: false);
    _fetchMeals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    _swiftAPI = Provider.of<SwiftAPI>(context);
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
            itemCount: meals.length,
            itemBuilder: (context, index) {
//              return Column(
//                children: <Widget>[
//                  ListTile(title: MealCard(meals[index])),
//                  Padding(
//                    padding: EdgeInsets.only(bottom: 50),
//                  )
//                ],
//              );
              return index % 5 != 0
                  ? Column(
                      children: <Widget>[
                        ListTile(title: MealCard(meals[index])),
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

  _fetchMeals(){
    _feedService.fetchFeedMeals(_swiftAPI,_userService.getUser().id, limit, offset).then((value){
     QueryResultsMealPojo results = value;
     setState(() {
       limit = results.limit;
       offset = results.offset;
       meals.addAll(results.results.toList());
     });
    }).catchError((e)=>errorResponseModal(context, e));
  }
}
