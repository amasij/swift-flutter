import 'package:swift_flutter/utils/name_code.dart';

class ErrorResponse extends NameAndCode{
   String message;
  ErrorResponse({this.message,String code}):super(code: code);
}