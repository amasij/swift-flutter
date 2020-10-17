import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _loginFormKey =
      GlobalKey<FormBuilderState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.orangeAccent,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          FormBuilder(
              key: _loginFormKey,
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 25),
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "firstName",
                      decoration: InputDecoration(labelText: "First Name"),
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    FormBuilderTextField(
                      attribute: "lastName",
                      decoration: InputDecoration(labelText: "Last Name"),
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                    FormBuilderTextField(
                      attribute: "email",
                      decoration: InputDecoration(labelText: "Email"),
                      validators: [
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ],
                    ),
                    FormBuilderPhoneField(
                      attribute: "phone",
                      defaultSelectedCountryIsoCode: "NG",
                      countryFilterByIsoCode: ["NG"],
                      decoration: InputDecoration(labelText: "Phone"),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 10)),
                     RaisedButton(
                      child: Text("Login"),
                      color: Colors.orangeAccent,
                      textColor: Colors.white,
                      onPressed: () {},
                    ),


//                    InternationalPhoneNumberInput(
//                      countries: ["NG"],
//                      onInputChanged: (PhoneNumber number) {
//                        print(number.phoneNumber);
//                      },
//                      onInputValidated: (bool value) {
//                        print(value);
//                      },
//                      selectorConfig: SelectorConfig(
//                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
//                        backgroundColor: Colors.black,
//                      ),
//                      ignoreBlank: false,
//                      autoValidateMode: AutovalidateMode.disabled,
//                      selectorTextStyle: TextStyle(color: Colors.black),
//                      initialValue: number,
//                      textFieldController: controller,
//                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
