import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class FoodPreferenceScreen extends StatefulWidget {
  @override
  _FoodPreferenceScreen createState() => _FoodPreferenceScreen();
}

class _FoodPreferenceScreen extends State<FoodPreferenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        title: Text("Select Preference"),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Resources.LOGIN_SCREEN_IMAGE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: FormBuilderFilterChip(
//decoration: InputDecoration(border: InputBorder.none),
                      selectedColor: Resources.APP_PRIMARY_COLOR,
                      checkmarkColor: Colors.white,
                      labelStyle: TextStyle(color: Colors.white),
                      spacing: 2,
                      attribute: "prefs",
                      options: [
                        FormBuilderFieldOption(
                            child: Text("All"), value: "all"),
                        FormBuilderFieldOption(
                            child: Text("Vegan"), value: "vegan"),
                        FormBuilderFieldOption(
                            child: Text("Fish"), value: "fish"),
                        FormBuilderFieldOption(
                            child: Text("Fast Food"), value: "fastFood"),
                        FormBuilderFieldOption(
                            child: Text("Local Food"), value: "cats"),
                        FormBuilderFieldOption(
                            child: Text("Meats"), value: "meats"),
                        FormBuilderFieldOption(
                            child: Text("Chinese"), value: "chinese"),
                        FormBuilderFieldOption(
                            child: Text("Indian"), value: "indian"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                    child: RaisedButton(
                      padding: EdgeInsets.only(top: 12, bottom: 12),
                      child: Text("Done"),
                      color: Resources.APP_PRIMARY_COLOR,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoute.homeScreen);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(
                      child: InkWell(
                        child: Text("Skip"),
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoute.homeScreen);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
