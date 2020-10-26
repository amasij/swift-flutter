import 'package:flutter/material.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        onGenerateRoute: AppRoute.generateRoute,
      home:  SplashScreen()
    );
  }
}
