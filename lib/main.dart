import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:openapi_generator_annotations/openapi_generator_annotations.dart';
import 'package:provider/provider.dart';
import 'package:swift_API/api.dart';
import 'package:swift_flutter/config/app_config.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

@Openapi(
    additionalProperties:
    AdditionalProperties(pubName: 'swift_API', pubAuthor: 'Simon Joseph',pubAuthorEmail: "simonjoseph750@gmail.com"),
    inputSpecFile: '${AppConfig.baseUrl}/v3/api-docs/',
    generatorName: Generator.DART_DIO,
    alwaysRun: true,
    outputDirectory: 'swift_api')
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) {
          BaseOptions options = new BaseOptions(
            baseUrl: AppConfig.baseUrl,
            connectTimeout: 100000,
            receiveTimeout: 30000,
          );
          return SwiftAPI(
            dio: new Dio(options),
            interceptors: [
              LogInterceptor(requestBody: true, responseBody: true)
            ],
          );
        },)
      ],
      child: MaterialApp(
        title: 'Swift',
        // theme: ThemeData(
        //   primarySwatch: Colors.brown,
        //   visualDensity: VisualDensity.adaptivePlatformDensity,
        // ),
          onGenerateRoute: AppRoute.generateRoute,
        home:  SplashScreen()
      ),
    );
  }
}
