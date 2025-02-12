import 'package:swift_API/api.dart';
import 'package:swift_API/model/user_creation_dto.dart';
import 'package:swift_API/model/user_pojo.dart';

class SignUpService {
  final SwiftAPI _swiftAPI = new SwiftAPI();

  UserCreationDto getUserCreationDto(
      String name, String phoneNumber, String email, String password) {
    return UserCreationDto((u) {
      u.name = name;
      u.phoneNumber = phoneNumber;
      u.email = email;
      u.password = password;
      return u.build();
    });
  }

  Future<UserPojo> registerUser(UserCreationDto dto) async {
    var response = await _swiftAPI.getUserControllerApi().registerUser(dto);
    if (response.statusCode == 200) {
      return response.data;
    }
    return null;
  }
}
