import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_pojo.dart';
import 'package:swift_API/model/query_results_meal_pojo.dart';
import 'package:swift_flutter/custom_widgets/error_response_modal.dart';
import 'package:swift_flutter/custom_widgets/meal_card.dart';
import 'package:swift_flutter/custom_widgets/restaurant_card.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/services/feed_service.dart';
import 'package:swift_flutter/services/user_service.dart';

class FeedScreen extends StatefulWidget {

  @override
  _FeedScreen createState() => _FeedScreen();
}

class _FeedScreen extends State<FeedScreen> with AutomaticKeepAliveClientMixin {
  FeedService _feedService = new FeedService();
  SwiftAPI _swiftAPI;
  UserService _userService;
  bool _feedEnd = false;
  int limit = 2;
  int offset = 0;
  List<MealPojo> meals = [];

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  ScrollController _controller;

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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    _swiftAPI = Provider.of<SwiftAPI>(context);
    super.build(context);
    return RefreshIndicator(
      onRefresh: _fetchMeals,
      key: _refreshIndicatorKey,
      child: NotificationListener<ScrollNotification>(
        onNotification: _handleScrollNotification,
        child: Column(
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
                    padding:
                        EdgeInsets.only(top: 4, left: 7, right: 7, bottom: 4),
                    selected: filterChips[key]['value'],
                    showCheckmark: false,
                    avatar: filterChips[key]['icon'],
                  );
                }).toList(),
              ),
//
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 14),
                  child: Text(
                    "Good evening, Simon",
                    style: TextStyle(fontWeight: FontWeight.w800),
                    textScaleFactor: 1.7,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  // print(_feedEnd);
                  // print(index == meals.length);
                  // if (_feedEnd && index == meals.length) {
                  //   return onFeedEnd();
                  // }
                  return index % 4 == 0
                      ? Column(
                          children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: restaurantCards.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: 10, bottom: 10, right: 10),
                                      height: 250,
                                      width: 370,
                                      child: restaurantCards[index],
                                    );
                                  }),
                            ),
                            ListTile(
                                title: MealCard(
                              meals[index],
                              triggerState: () => setState(() {}),
                            )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                            )
                          ],
                        )
                      : Column(
                          children: <Widget>[
                            ListTile(
                                title: MealCard(
                              meals[index],
                              triggerState: () => setState(() {}),
                            )),
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                            )
                          ],
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container onFeedEnd() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 15),
      padding: EdgeInsets.all(10.0),
      decoration:
          BoxDecoration(border: Border.all(color: Resources.APP_PRIMARY_COLOR)),
      child: Text(
        'No more meals available',
        style: TextStyle(color: Resources.APP_PRIMARY_COLOR),
      ),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      if (notification.metrics.extentAfter < 400) {
        if (!_feedEnd) {
          offset += 2;
          _fetchMeals();
        }
      }
    }
    return false;
  }

  Future _fetchMeals() {
    return _feedService
        .fetchFeedMeals(_swiftAPI, _userService.getUser().id, limit, offset)
        .then((value) {
      QueryResultsMealPojo results = value;
      setState(() {
        results.results.isEmpty ? _feedEnd = true : _feedEnd = false;
        limit = results.limit;
        offset = results.offset;
        meals.addAll(results.results
            .toList()
            .where((element) => !meals.contains(element)));
      });
    }).catchError((e) => errorResponseModal(context, e));
  }

  @override
  bool get wantKeepAlive => true;
}
