import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_category.dart';
import 'package:swift_flutter/custom_widgets/app_form.dart';
import 'package:swift_flutter/resources/resources.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreen createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  List<MealCategory> mealCategories = [];
  SwiftAPI _api;
  double _crossAxisSpacing = 8, _mainAxisSpacing = 12, _aspectRatio = 2;
  int _crossAxisCount = 2;
  FormGroup _form = FormGroup({
    'search': FormControl<String>(),
  });

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _api.getMealCategoryControllerApi().getMeal().then((value) {
        if (value.statusCode == 200) {
          setState(() {
            mealCategories = value.data;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _api = Provider.of(context);
    return Container(
      child: ReactiveForm(
        formGroup: _form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AppTextField(formControlName: 'search', hintText: 'Search',),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                ),
                itemBuilder: (_, index) => Container(
                    decoration: BoxDecoration(
                      color: Resources.SOFT_COLORS[
                          Random().nextInt(Resources.SOFT_COLORS.length)],
                      borderRadius: BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    height: 50,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          left: 5,
                          child: Text(
                            mealCategories[index].name.toUpperCase(),
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w800),
                            textScaleFactor: 1.3,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: -20,
                          child: Image.asset(
                            "assets/images/meal-category/${mealCategories[index].code}.png",
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ],
                    )),
                itemCount: mealCategories.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
