import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swift_flutter/custom_widgets/app_button.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/utils/error_response.dart';
import 'package:dio/dio.dart';
import 'package:swift_flutter/utils/utils.dart';

Future errorResponseModal(BuildContext context, DioError e) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) => AlertDialog(
            actionsPadding: EdgeInsets.only(right: 5, top: 0),
            contentPadding:
                EdgeInsets.only(top: 24, left: 24, right: 24, bottom: 0),
            content: Container(
              height: 160,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Image.asset(
                    Resources.ERROR_ICON,
                    width: 100,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Flexible(
                    child: Text(
                      Utils.isNotNull(e.response) ?
                      e.response.data['message'] : "Cannot connect to server",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      textScaleFactor: 1,

                    ),
                  )
                ],
              ),
            ),
            actions: <Widget>[
              AppButton(
                transparent: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Close',
              )
            ],
          ));
}
