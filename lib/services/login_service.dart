import 'package:swift_API/api.dart';
import 'package:swift_API/model/user_pojo.dart';
import 'package:swift_API/model/login_dto.dart';

class LoginService {
  LoginDto getLoginDto(String identifier, String password) {
    return LoginDto((u) {
      u.identifier = identifier;
      u.password = password;
      return u.build();
    });
  }

  Future<UserPojo> login(SwiftAPI swiftAPI, LoginDto dto) async {
    var response = await swiftAPI.getUserControllerApi().login(dto);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
