import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resources {
  static const Map<int, Color> primaryColorSwatch = {
    50: Color.fromRGBO(90, 158, 47, .1),
    100: Color.fromRGBO(90, 158, 47, .2),
    200: Color.fromRGBO(90, 158, 47, .3),
    300: Color.fromRGBO(90, 158, 47, .4),
    400: Color.fromRGBO(90, 158, 47, .5),
    500: Color.fromRGBO(90, 158, 47, .6),
    600: Color.fromRGBO(90, 158, 47, .7),
    700: Color.fromRGBO(90, 158, 47, .8),
    800: Color.fromRGBO(90, 158, 47, .9),
    900: Color.fromRGBO(90, 158, 47, 1),
  };

  static const List<Color> SOFT_COLORS = [
    Color(0xffee9595),
    Color(0xffe7d9ea),
    Color(0xffef4f4f),
    Color(0xff433d3c),
    Color(0xff70af85),
    Color(0xff583d72),
    Color(0xffc5a880),
    Color(0xff532e1c),
    Color(0xffc24914),
    Color(0xff79a3b1),
    Color(0xffffe3d8),
    Color(0xffa9294f),
    Color(0xff222831),
    Color(0xffd68060),
    Color(0xff21209c),
    Color(0xffd1c145),
    Color(0xffa6a9b6),
    Color(0xffe9b0df)
  ];
  static const String SPLASH_SCREEN_IMAGE = "assets/images/splash.png";
  static const String BURGER_IMAGE = "assets/images/burger.jpg";
  static const String LOGIN_SCREEN_IMAGE = "assets/images/login_screen.png";
  static const String BG_IMAGE = "assets/images/bg.png";
  static const String RESTAURANT_IMAGE_1 = "assets/images/restaurant1.png";
  static const String RESTAURANT_IMAGE_2 = "assets/images/restaurant2.png";
  static const String RESTAURANT_IMAGE_3 = "assets/images/restaurant3.png";
  static const String ERROR_ICON = "assets/images/close.png";
  static const String SPINNER = "assets/images/spinner.gif";
  static const String SHARED_PREFERENCES_LOGGED_IN_USER = "LOGGED_IN_USER";
  static const String SHARED_PREFERENCES_CART_ITEMS = "CART_ITEMS";
  static const Color APP_PRIMARY_COLOR = Color(0xFF5A9E2F);
  static const MaterialColor APP_PRIMARY_COLOR_MATERIAL =
      MaterialColor(0xFF5A9E2F, primaryColorSwatch);
}
