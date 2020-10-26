import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _loginFormKey =
      GlobalKey<FormBuilderState>();

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Resources.LOGIN_SCREEN_IMAGE),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            FormBuilder(
                key: _loginFormKey,
                child: Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[

                      FormBuilderTextField(
                        attribute: "email",
                        decoration: InputDecoration(labelText: "Email"),
                        validators: [
                          FormBuilderValidators.required(errorText:"Email is required"),
                          FormBuilderValidators.email(errorText:"Not a valid email"),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                      FormBuilderTextField(
                        obscureText: true,
                        attribute: "password",
                        decoration: InputDecoration(labelText: "Password"),
                        validators: [
                          FormBuilderValidators.required(errorText: "Password is required"),

                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: RaisedButton(
                          padding: EdgeInsets.only(top: 12, bottom: 12),
                          child: Text("Login"),
                          color: Resources.APP_PRIMARY_COLOR,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoute.homeScreen);
                          },
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Text("Sign up"),
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoute.signUpScreen);
                                },
                              ),
                              Text("Forgot Password?")
                            ],
                          )
                      )
                    ],
                  ),
                )))
          ],
        ),
      ),
    );
  }
}
