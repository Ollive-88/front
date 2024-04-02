import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ollive_front/main.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

// 인스턴스 생성
const secureStorage = FlutterSecureStorage();

class UserController {
  final mContext = navigatorKey.currentContext;

  Future<bool> login(Login input) async {
    ResponseDTO responseDTO = await UserService.loginAction(input);

    if (responseDTO.code == 1) {
      // 토큰을 휴대폰에 저장
      await secureStorage.write(
          key: 'accessToken', value: responseDTO.accessToken);
      await secureStorage.write(
          key: 'refreshToken', value: responseDTO.refreshToken);

      // 전역에 등록
      Get.find<StatusController>().setToken(Token(
        accessToken: responseDTO.accessToken,
        refreshToken: responseDTO.refreshToken,
      ));
      return true;
    } else {
      return false;
    }
  }
}
