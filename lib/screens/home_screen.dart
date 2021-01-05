import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/screens/feed_screen.dart';
import 'package:swift_flutter/screens/profile_screen.dart';
import 'package:swift_flutter/screens/search_screen.dart';
import 'package:swift_flutter/services/cart_service.dart';

class HomeScreen extends StatefulWidget {
  String homeScreen = '/homeScreen';

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  CartService _cartService;



  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabs = [FeedScreen(), SearchScreen(), ProfileScreen()];
    _cartService = Provider.of(context);
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Resources.APP_PRIMARY_COLOR,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('')),
            new BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text(''))
          ],
        ),
        appBar: AppBar(
          title: Text("Swift"),
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: () {
                print("cart tapped");
              },
              child: Padding(
                padding: EdgeInsets.only(right: 14),
                child: StreamBuilder(
                  stream: _cartService.stream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return snapshot.hasData &&
                            (snapshot.data as List).length > 0
                        ? Badge(
                            padding: EdgeInsets.all(3),
                            position: BadgePosition(top: 4, start: 17),
                            badgeContent: Text(
                              (snapshot.data as List).length.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            child: Icon(Icons.shopping_cart),
                          )
                        : Icon(Icons.shopping_cart);
                  },
                ),
              ),
            )
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: _tabs,
        ));
  }
}
