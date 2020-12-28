import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:swift_API/model/meal_category.dart';
import 'package:swift_API/model/user_preference_dto.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/food_preference_service.dart';
import 'package:swift_flutter/services/user_service.dart';

class FoodPreferenceScreen extends StatefulWidget {
  @override
  _FoodPreferenceScreen createState() => _FoodPreferenceScreen();
}

class _FoodPreferenceScreen extends State<FoodPreferenceScreen> {
  FoodPreferenceService _foodPreferenceService = new FoodPreferenceService();
  final GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();
  List<MealCategory> _mealCategories = [];
  List _selectedCategories = [];
  UserService _userService;

  @override
  void initState() {
    _foodPreferenceService.fetchMealCategories().then((value) {
      setState(() {
        _mealCategories = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Resources.APP_PRIMARY_COLOR,
          title: Text("Select Preference"),
          automaticallyImplyLeading: false,
        ),
        body: Background(
          child: Container(
            child:
            FormBuilder(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _mealCategories.isEmpty
                      ? _foodPreferenceService.getShimmer()
                      : Padding(
                          padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                          child: FormBuilderFilterChip(
                            selectedColor: Resources.APP_PRIMARY_COLOR,
                            checkmarkColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.white),
                            spacing: 2,
                            attribute: "prefs",
                            options: _foodPreferenceService.transform(_mealCategories),
                            onChanged: (v ){
                            _selectedCategories = (v as List<dynamic>).map((e) => e.toString()).toList();
                            },
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 10,
                          child: OutlineButton(
                            child: Text("Skip"),
                            color: Colors.white,
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoute.homeScreen);
                            },
                            textColor: Resources.APP_PRIMARY_COLOR,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Resources.APP_PRIMARY_COLOR,
                                width: 3,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                          flex: 1,
                        ),
                        Expanded(
                          flex: 10,
                          child: RaisedButton(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: Text("Done"),
                            color: Resources.APP_PRIMARY_COLOR,
                            textColor: Colors.white,
                            onPressed: () async{
                             if(_selectedCategories.isNotEmpty){
                               UserPreferenceDto dto = _foodPreferenceService.getUserPreferenceDto(_selectedCategories);
                              await _foodPreferenceService.saveFoodPreferences(_userService.getUser().id, dto);
                             }
                              Navigator.pushNamed(context, AppRoute.homeScreen);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }


}
