import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  final GlobalKey<FormBuilderState> _key =
      GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset:false,
      appBar: AppBar(
        title: Text("Sign Up"),
        backgroundColor: Resources.APP_PRIMARY_COLOR,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Resources.LOGIN_SCREEN_IMAGE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                    key: _key,
                    child: Padding(
                        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            FormBuilderTextField(
                              attribute: "firstName",
                              decoration:
                                  InputDecoration(labelText: "First Name"),
                              validators: [
                                FormBuilderValidators.required(errorText: "First name is required"),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            FormBuilderTextField(
                              attribute: "lastName",
                              decoration:
                                  InputDecoration(labelText: "Last Name"),
                              validators: [
                                FormBuilderValidators.required(errorText:"Last name is required"),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            FormBuilderTextField(
                              attribute: "email",
                              decoration: InputDecoration(labelText: "Email"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.email(errorText:"Not a valid email"),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            FormBuilderTextField(
                              obscureText: true,
                              attribute: "password",
                              decoration:
                                  InputDecoration(labelText: "Password"),
                              validators: [
                                FormBuilderValidators.required(errorText: "Password is required"),
                                FormBuilderValidators.min(6,errorText: "Password must be at least 6 characters"),
                              ],
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 10)),
                            FormBuilderTextField(
                              obscureText: true,
                              attribute: "confirmPassword",
                              decoration:
                              InputDecoration(labelText: "Confirm Password"),
                              validators: [
                                FormBuilderValidators.required(),
                                FormBuilderValidators.min(6,errorText: "Password must be at least 6 characters")
                              ],
                            ),
                            FormBuilderPhoneField(
                              attribute: "phone",
                              defaultSelectedCountryIsoCode: "NG",
                              countryFilterByIsoCode: ["NG"],
                              decoration: InputDecoration(labelText: "Phone"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: RaisedButton(
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                child: Text("Sign Up"),
                                color: Resources.APP_PRIMARY_COLOR,
                                textColor: Colors.white,
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoute.foodPreferenceScreen);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Center(
                                child: InkWell(
                                  child: Text("Login"),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, AppRoute.loginScreen);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
