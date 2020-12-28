import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_API/api.dart';
import 'package:dio/dio.dart';
import 'package:phone_number/phone_number.dart' as phone;

class EmailValidator extends Validator<dynamic> {
  static final RegExp emailRegex = new RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  @override
  Map<String, dynamic> validate(AbstractControl<dynamic> control) {
    if (control == null || control.value == null) return null;
    final error = {ValidationMessage.email: control.value.trim()};
    return (control.isNull ||
            control.value.trim().toString().isEmpty ||
            emailRegex.hasMatch(control.value.trim().toString().toString()))
        ? null
        : error;
  }
}

Future<Map<String, dynamic>> Function(AbstractControl) validatePhoneFormat =
    (e) async {
  if (e.invalid) {
    e.markAsTouched();
    return e.errors;
  }
  if (e.value.length != 14) {
    e.markAsTouched();
    return <String, dynamic>{'Invalid format': true};
  }
  try {
    var map = await phone.PhoneNumber().parse(e.value, region: 'NG');
    return null;
  } catch (ex) {
    print(ex);

    e.markAsTouched();
    return <String, dynamic>{'Invalid format': true};
  }
};

Future<Map<String, dynamic>> phoneNumberExists(AbstractControl e) async {
  FormControl f = e as FormControl;
  SwiftAPI swiftAPI = new SwiftAPI();
  try {
    print(f.value);
    await swiftAPI
        .getVerificationControllerApi()
        .verifyResource(f.value, 'PHONE_NUMBER');
    return null;
  } catch (err) {
    print(err);
    var error;
    if (err is DioError && err.response.statusCode == 409) {
      error = {'alreadyExists': true};
    }
    e.markAsTouched();
    return error;
  }
}

Future<Map<String, dynamic>> emailExists(AbstractControl e) async {
  FormControl f = e as FormControl;
  SwiftAPI swiftAPI = new SwiftAPI();
  try {
    print(f.value);
    await swiftAPI
        .getVerificationControllerApi()
        .verifyResource(f.value, 'EMAIL');
    return null;
  } catch (err) {
    print(err);
    var error;
    if (err is DioError && err.response.statusCode == 409) {
      error = {'alreadyExists': true};
    }
    e.markAsTouched();
    return error;
  }
}
