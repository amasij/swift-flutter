import 'package:flutter/material.dart';
import 'package:swift_flutter/screens/home_screen.dart';
import 'package:swift_flutter/screens/login_screen.dart';
import 'package:swift_flutter/screens/splash_screen.dart';

class AppRoute {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
