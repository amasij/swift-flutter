import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_category.dart';
import 'package:swift_API/model/meal_category_pojo.dart';
import 'package:swift_API/model/user_preference_dto.dart';
import 'package:swift_flutter/custom_widgets/app_shimmer.dart';
import 'package:swift_flutter/resources/resources.dart';

class FoodPreferenceService {
  final SwiftAPI _swiftAPI = new SwiftAPI();

  Future<List<MealCategory>> fetchMealCategories() async {
    var response = await _swiftAPI.getMealCategoryControllerApi().getMeal();
    if (response.statusCode == 200) {
      return response.data;
    }
    return [];
  }

  List<FormBuilderFieldOption> transform(List<MealCategory> categories) {
    categories.sort((x, y) {
      return x.name.compareTo(y.name);
    });
    return categories
        .map(
          (e) => FormBuilderFieldOption(child: Text(e.name), value: e.code),
        )
        .toList();
  }

  AppShimmer getShimmer() {
    return AppShimmer(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
        child: FormBuilderFilterChip(
          selectedColor: Resources.APP_PRIMARY_COLOR,
          checkmarkColor: Colors.white,
          labelStyle: TextStyle(color: Colors.white),
          spacing: 2,
          attribute: "prefs",
          options: [
            FormBuilderFieldOption(child: Text("All"), value: "all"),
            FormBuilderFieldOption(child: Text("Vegan"), value: "vegan"),
            FormBuilderFieldOption(child: Text("Fish"), value: "fish"),
            FormBuilderFieldOption(child: Text("Fast Food"), value: "fastFood"),
            FormBuilderFieldOption(child: Text("Local Food"), value: "cats"),
            FormBuilderFieldOption(child: Text("Meats"), value: "meats"),
            FormBuilderFieldOption(child: Text("Chinese"), value: "chinese"),
            FormBuilderFieldOption(child: Text("Indian"), value: "indian"),
          ],
        ),
      ),
    );
  }
UserPreferenceDto getUserPreferenceDto(List<String> codes){
    return UserPreferenceDto((b){
     codes.forEach((e) => b.codes.add(e));
      return b;
    });
}

  Future<List<MealCategoryPojo>> saveFoodPreferences(int userId, UserPreferenceDto dto) async{
   var response = await _swiftAPI.getUserControllerApi().setUserPreferences(userId, dto);
   if(response.statusCode == 200){
     return response.data;
   }else{
     return [];
   }
  }
}
