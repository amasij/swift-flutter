import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/user_creation_dto.dart';
import 'package:swift_flutter/custom_widgets/app_button.dart';
import 'package:swift_flutter/custom_widgets/app_form.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/signup_service.dart';
import 'package:swift_flutter/services/user_service.dart';
import 'package:swift_flutter/utils/custom_validators.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  FormGroup _form = FormGroup({
    'name': FormControl<String>(
        validators: [Validators.required, Validators.minLength(3)]),
    'email': FormControl<String>(
        validators: [Validators.required, EmailValidator().validate],
        asyncValidatorsDebounceTime: 700,
        asyncValidators: [emailExists]),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
    'phone': FormControl<String>(
        validators: [Validators.required, Validators.minLength(10)],
        asyncValidators: [phoneNumberExists, validatePhoneFormat],
        asyncValidatorsDebounceTime: 700),
  });

  SignUpService _signUpService = new SignUpService();
  UserService _userService;
  SwiftAPI _swiftAPI;

  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    _swiftAPI = Provider.of<SwiftAPI>(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Resources.APP_PRIMARY_COLOR,
          automaticallyImplyLeading: false,
        ),
        body: Background(
          child: Container(
            child: Column(
              children: <Widget>[
                ReactiveForm(
                  formGroup: _form,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppTextField(
                          formControlName: "name",
                          hintText: "Enter Name",
                          validationMessages: {
                            ValidationMessage.required: 'Your name is required',
                            ValidationMessage.minLength:
                                'This name is too short',
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppTextField(
                          formControlName: "email",
                          hintText: "Enter Email",
                          validationMessages: {
                            ValidationMessage.required:
                                'Your email is required',
                            ValidationMessage.email:
                                'This is not a valid email',
                            'alreadyExists': 'This Email already exists.'
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppTextField(
                          formControlName: "password",
                          hintText: "Password",
                          obscureText: true,
                          validationMessages: {
                            ValidationMessage.required:
                                'Your password is required',
                            ValidationMessage.minLength:
                                'your password must be at least 6 characters',
                          },
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppPhoneNumberField(
                          formControlName: "phone",
                          hintText: "Enter Phone",
                          validationMessages: {
                            ValidationMessage.required:
                                'Your phone number is required',
                            ValidationMessage.minLength:
                                'This is not a valid phone number',
                            'alreadyExists': 'This phone number already exists.'
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 10,
                                  child: AppButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, AppRoute.loginScreen),
                                    text: 'Login',
                                    transparent: true,
                                  )),
                              Expanded(
                                child: SizedBox(),
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: AppButton(
                                    text: 'Sign Up',
                                    onPressed: () {
                                      _form.markAllAsTouched();
                                      if (_form.valid) {
                                        UserCreationDto dto =
                                            _signUpService.getUserCreationDto(
                                                _form.control("name").value,
                                                _form.control("phone").value,
                                                _form.control("email").value,
                                                _form
                                                    .control("password")
                                                    .value);

                                        _signUpService
                                            .registerUser(_swiftAPI, dto)
                                            .then((value) {
                                          _userService.setUser(value);
                                          Navigator.pushNamed(context,
                                              AppRoute.foodPreferenceScreen);
                                        });
                                      }
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
