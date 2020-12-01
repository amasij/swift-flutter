import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:swift_flutter/custom_widgets/app_form.dart';
import 'package:swift_flutter/custom_widgets/background.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  FormGroup _form = FormGroup({
    'emailPhone': FormControl<String>(validators: [Validators.required]),
    'password': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        automaticallyImplyLeading: false,
      ),
      body: Background(
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
                          formControlName: "emailPhone",
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
                              child: OutlineButton(
                                child: Text("Sign up"),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.signUpScreen);
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
                                child: Text("Login"),
                                color: Resources.APP_PRIMARY_COLOR,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.homeScreen);
                                },
                              ),
                            )
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
    );
  }
}
