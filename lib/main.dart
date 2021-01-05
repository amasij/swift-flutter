import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_API/api.dart';
import 'package:swift_flutter/config/app_config.dart';
import 'package:swift_flutter/config/error_interceptor.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/screens/splash_screen.dart';
import 'package:swift_flutter/services/cart_service.dart';
import 'package:swift_flutter/services/user_service.dart';

void main() {
  runApp(MyApp());
}

@Openapi(
    additionalProperties: AdditionalProperties(
        pubName: 'swift_API',
        pubAuthor: 'Simon Joseph',
        pubAuthorEmail: "simonjoseph750@gmail.com"),
    inputSpecFile: '${AppConfig.baseUrl}/v3/api-docs/',
    generatorName: Generator.DART_DIO,
    alwaysRun: true,
    outputDirectory: 'swift_api')
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) {
            BaseOptions options = new BaseOptions(
              baseUrl: AppConfig.baseUrl,
              connectTimeout: 100000,
              receiveTimeout: 30000,
            );
            return SwiftAPI(
              dio: new Dio(options),
              interceptors: [
//                ErrorInterceptor(),
                PrettyDioLogger(
                  requestHeader: true,
                  requestBody: true,
                  responseBody: true,
                  responseHeader: false,
                  error: true,
                  compact: true,
                  maxWidth: 90,
                ),

//                LogInterceptor(requestBody: true, responseBody: true)
              ],
            );
          },
        ),
        Provider(create: (_) {
          return new UserService();
        }),
        Provider(create: (_) {
          return new CartService();
        }),
      ],
      child: MaterialApp(
          title: 'Swift',
          theme: ThemeData(
            primarySwatch: Resources.APP_PRIMARY_COLOR_MATERIAL,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              inputDecorationTheme: InputDecorationTheme(
                  hintStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(color: Colors.black),
                  fillColor: Colors.black12,
                  filled: true)
              /* dark theme settings */
              ),
          themeMode: ThemeMode.dark,
          onGenerateRoute: AppRoute.generateRoute,
          home: SplashScreen()),
    );
  }
}
