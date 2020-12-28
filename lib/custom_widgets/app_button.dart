import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swift_flutter/resources/resources.dart';

class AppButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final bool transparent;

  AppButton({@required this.onPressed, @required this.text, this.transparent = false});

  @override
  Widget build(BuildContext context) {
    return !transparent
        ? RaisedButton(
            padding: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(text),
            color: Resources.APP_PRIMARY_COLOR,
            textColor: Colors.white,
            onPressed: onPressed)
        : OutlineButton(
            child: Text(text),
            color: Colors.white,
            onPressed: onPressed,
            textColor: Resources.APP_PRIMARY_COLOR,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Resources.APP_PRIMARY_COLOR,
                width: 3,
              ),
            ),
          );
  }
}
