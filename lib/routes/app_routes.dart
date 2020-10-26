import 'package:flutter/material.dart';
import 'package:swift_flutter/screens/food_preference_screen.dart';
import 'package:swift_flutter/screens/home_screen.dart';
import 'package:swift_flutter/screens/login_screen.dart';
import 'package:swift_flutter/screens/signup_screen.dart';
import 'package:swift_flutter/screens/splash_screen.dart';

class AppRoute {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/loginScreen';
  static const String signUpScreen = '/signUpScreen';
  static const String foodPreferenceScreen = '/foodPreferenceScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case foodPreferenceScreen:
        return MaterialPageRoute(builder: (_) => FoodPreferenceScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
