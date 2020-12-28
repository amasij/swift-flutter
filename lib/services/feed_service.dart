import 'package:swift_API/api.dart';
import 'package:swift_API/model/meal_filter.dart';
import 'package:swift_API/model/meal_pojo.dart';
import 'package:swift_API/model/query_results_meal_pojo.dart';
import 'package:swift_flutter/utils/error_response.dart';

class FeedService {

  Future<QueryResultsMealPojo> fetchFeedMeals(SwiftAPI swiftAPI, int userId, int limit, int offset) async {
    var response = await swiftAPI.getMealControllerApi().getUserMeals(userId,limit, offset);
    if(response.statusCode == 200){
      return response.data;
    }
    throw ErrorResponse(message:"Unable to fetch meals");
  }
}
