import 'package:rxdart/rxdart.dart';
import 'package:swift_API/model/user_pojo.dart';
import 'dart:convert';
import 'package:swift_flutter/resources/resources.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final BehaviorSubject<UserPojo> _subject = BehaviorSubject<UserPojo>();

  Future<UserPojo> initUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = sharedPreferences.getString(Resources.SHARED_PREFERENCES_LOGGED_IN_USER);
    if(data == null){
      _subject.add(null);
      throw('Not logged in.');
    }else{
      UserPojo user = _decoder(data);
      _subject.add(user);
      return user;
    }
  }

  setUser(UserPojo user) async {
    _subject.add(user);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Resources.SHARED_PREFERENCES_LOGGED_IN_USER,
        jsonEncode(user, toEncodable: (user) => _encoder(user)));
  }

  removeUser() async{
    _subject.add(null);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(Resources.SHARED_PREFERENCES_LOGGED_IN_USER);
  }

  UserPojo getUser() {
    return _subject.value;
  }

  get listen$ {
    return _subject.stream.listen;
  }

  Map<String, dynamic> _encoder(UserPojo u) {
    return {
      "email": u.email,
      "id": u.id,
      "phoneNumber": u.phoneNumber,
      "name": u.name
    };
  }

  UserPojo _decoder(String data) {
    Map<String, dynamic> user = jsonDecode(data);
    return UserPojo((u) {
      u.name = user['name'];
      u.id = user['id'];
      u.phoneNumber = user['phoneNumber'];
      u.email = user['email'];
      return u.build();
    });
  }
}
