import 'package:flutter/material.dart';
import 'package:swift_flutter/screens/home_screen.dart';
import 'package:swift_flutter/screens/splash_screen.dart';

//class PageSlideTransition extends PageRouteBuilder {
//  final Widget page;
//
//  PageSlideTransition({this.page}): super(
//      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) => page,
//      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
//        var begin = Offset(0.0, 1.0);
//        var end = Offset.zero;
//        var curve = Curves.ease;
//        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//
//        return SlideTransition(
//            position: animation.drive(tween),
//            child: child
//        );
//      },
//      transitionDuration: Duration(milliseconds: 500)
//  );
//}

class AppRoute {
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());



      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
