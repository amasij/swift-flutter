import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/screens/feed_screen.dart';
import 'package:swift_flutter/screens/profile_screen.dart';
import 'package:swift_flutter/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  String homeScreen = '/homeScreen';
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [FeedScreen(), SearchScreen(), ProfileScreen()];

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
                child:  Badge(
                  padding: EdgeInsets.all(3),
                 position: BadgePosition(top: 4,start: 17),
                  badgeContent: Text('4',style: TextStyle(color: Colors.white),),
                  child: Icon(Icons.shopping_cart),
                ),
              ),
            )
          ],
        ),
        body: tabs[_currentIndex]);
  }
}
