import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swift_flutter/custom_widgets/meal_card.dart';
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
  String homeScreen = '/homeScreen';
  @override
  void dispose() {
    super.dispose();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [FeedScreen(), SearchScreen(), ProfileScreen()];

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.deepOrange,
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
        ),
        body: widgets[_currentIndex]);
  }
}
