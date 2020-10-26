import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreen createState() => _UserProfileScreen();
}

class _UserProfileScreen extends State<UserProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Resources.APP_PRIMARY_COLOR,
          automaticallyImplyLeading: true,
          actions: [
            Text("Log out")
          ],
        ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Resources.SPLASH_SCREEN_IMAGE),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}
