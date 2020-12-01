import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:basic_utils/basic_utils.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 2),
            () {
              SharedPreferences.getInstance().then((pref) => {

                if(StringUtils.isNullOrEmpty(pref.getString(Resources.PREF_USERNAME))
                    && StringUtils.isNullOrEmpty(pref.getString(Resources.PREF_PASSWORD))){
                  Navigator.pushNamed(context, AppRoute.loginScreen)
                }else{
                  Navigator.pushNamed(context, AppRoute.homeScreen)
                }
              });
        }

    );
  }



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
