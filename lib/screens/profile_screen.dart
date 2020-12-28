import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swift_flutter/resources/resources.dart';
import 'package:swift_flutter/routes/app_routes.dart';
import 'package:swift_flutter/services/user_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  UserService _userService;
  @override
  Widget build(BuildContext context) {
    _userService = Provider.of<UserService>(context);
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(Resources.BURGER_IMAGE),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Simon Joseph",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 15),
              child: Text(
                "simonjoseph750@gmail.com",
                style: TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
        Card(
          elevation: 0.1,
          child: ListTile(
            leading: Icon(Icons.receipt),
            title: Text('My Orders'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35),
        ),
        Card(
          elevation: 0.3,
          margin: EdgeInsets.only(bottom: 0.3),
          child: ListTile(
            leading: Icon(Icons.person),
            title: Text('My Details'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Card(
          elevation: 0.2,
          margin: EdgeInsets.only(bottom: 0.3,top: 0),
          child: ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Payment Methods'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Card(
          elevation: 0.2,
          margin: EdgeInsets.only(bottom: 0.3,top: 0),
          child: ListTile(
            leading: Icon(Icons.pin_drop),
            title: Text('Delivery Address'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Card(
          elevation: 0.2,
          margin: EdgeInsets.only(bottom: 0,top: 0),
          child: ListTile(
            leading: Icon(Icons.restore),
            title: Text('Payment History'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 35),
        ),
        Card(
          elevation: 0.2,
          margin: EdgeInsets.only(bottom: 0.3,top: 0),
          child: ListTile(
            title: Text('About'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: Resources.APP_PRIMARY_COLOR,
            ),
          ),
        ),
        Card(
          elevation: 0.2,
          margin: EdgeInsets.only(bottom: 0,top: 0),
          child: ListTile(
            onTap: (){
              _userService.removeUser();
              Navigator.pushNamed(context, AppRoute.loginScreen);
            },
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ),
      ],
    );
  }
}
