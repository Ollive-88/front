import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ollive_front/main.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/service/user/user_service.dart';

// 인스턴스 생성
const secureStorage = FlutterSecureStorage();

class UserController {
  final mContext = navigatorKey.currentContext;

  Future<bool> login(Login input) async {
    ResponseDTO responseDTO = await UserService().loginAction(input);

    if (responseDTO.code == 1) {
      // 토큰을 휴대폰에 저장
      await secureStorage.write(key: 'token', value: responseDTO.token);
      await secureStorage.write(
          key: 'refreshToken', value: responseDTO.refreshToken);
      return true;
    } else {
      return false;
    }
  }
}
