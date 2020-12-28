import 'package:dio/dio.dart';
import 'package:swift_flutter/utils/error_response.dart';
class ErrorInterceptor extends Interceptor{

  @override
  Future<ErrorResponse> onError(DioError err) {
    return Future.value(new ErrorResponse(message:err.response.data['message'], code: err.response.data['code'].toString() ));
  }
}
