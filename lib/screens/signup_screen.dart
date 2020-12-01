import 'dart:async';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_API/model/user_creation_dto.dart';
import 'package:swift_flutter/custom_widgets/app_form.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/signup_service.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  FormGroup _form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'email': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
    'phone': FormControl<String>(validators: [Validators.required]),
  });

  SignUpService _signUpService = new SignUpService();

  @override
  Widget build(BuildContext context) {
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
                            formControlName: "name", hintText: "Enter Name"),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppTextField(
                            formControlName: "email", hintText: "Enter Email"),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppTextField(
                          formControlName: "password",
                          hintText: "Password",
                          obscureText: true,
                        ),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppPhoneNumberField(
                          formControlName: "phone",
                          hintText: "Enter Phone",
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 10,
                                child: OutlineButton(
                                  child: Text("Login"),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.loginScreen);
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
                                  child: Text("Sign Up"),
                                  color: Resources.APP_PRIMARY_COLOR,
                                  textColor: Colors.white,
                                  onPressed: () {
                                    _form.markAllAsTouched();
                                    if (_form.valid) {
                                      UserCreationDto dto =
                                          _signUpService.getUserCreationDto(
                                              _form.control("name").value,
                                              _form.control("phone").value,
                                              _form.control("email").value,
                                              _form.control("password").value);

                                      _signUpService
                                          .registerUser(dto)
                                          .then((value) {
                                        //todo add token
                                        print(value);
                                        Navigator.pushNamed(context,
                                            AppRoute.foodPreferenceScreen);
                                      });
                                    }
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
              ],
            ),
          ),
        ));
  }
}
