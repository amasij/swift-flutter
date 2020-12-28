import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift_API/api.dart';
import 'package:swift_API/model/login_dto.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_flutter/custom_widgets/app_button.dart';
import 'package:swift_flutter/custom_widgets/app_form.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/custom_widgets/error_response_modal.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/login_service.dart';
import 'package:swift_flutter/services/user_service.dart';
import 'package:swift_flutter/utils/error_response.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  SwiftAPI _swiftAPI;
  bool _loading = false;
  LoginService _loginService = new LoginService();
  UserService _userService;
  SharedPreferences _sharedPreferences;

  FormGroup _form = FormGroup({
    'identifier': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    _swiftAPI = Provider.of<SwiftAPI>(context);
    _userService = Provider.of<UserService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        automaticallyImplyLeading: false,
      ),
      body: ModalProgressHUD(
        dismissible: false,
        inAsyncCall: _loading,
        child: Background(
          child: Column(
            children: <Widget>[
//            SizedBox(
//              height: MediaQuery.of(context).size.height * 0.2,
//            ),
              ReactiveForm(
                  formGroup: _form,
                  child: Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        AppTextField(
                            formControlName: "identifier",
                            hintText: "Email or Phone number"),
                        Padding(padding: EdgeInsets.only(bottom: 10)),
                        AppTextField(
                          formControlName: "password",
                          hintText: "Password",
                          obscureText: true,
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
                                      context, AppRoute.signUpScreen),
                                  text: 'Sign Up',
                                  transparent: true,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(),
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: AppButton(
                                    text: 'Login',
                                    onPressed: () {
                                      _form.markAllAsTouched();
                                      if (_form.valid) {
                                        LoginDto dto =
                                            _loginService.getLoginDto(
                                                _form
                                                    .control("identifier")
                                                    .value,
                                                _form
                                                    .control("password")
                                                    .value);

                                        setState(() {
                                          _loading = true;
                                        });

                                        _loginService
                                            .login(_swiftAPI, dto)
                                            .then((user) {
                                              _userService.setUser(user);

                                              Navigator.pushNamed(
                                                  context, AppRoute.homeScreen);
                                            })
                                            .catchError((e) =>
                                                errorResponseModal(context, e))
                                            .whenComplete(
                                              () => setState(
                                                () {
                                                  _loading = false;
                                                },
                                              ),
                                            );
                                      }
                                    },
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text("Forgot Password?")],
                            ))
                      ],
                    ),
                  )))
            ],
          ),
        ),
      ),
    );
  }
}
