import 'package:get/get.dart';

class StatusController extends GetxController {
  Token _token = Token();

  Token get token => _token;

  void setToken(Token newToken) {
    _token = newToken;
  }

  final RxString _nickname = ''.obs;
  final RxString _imgUrl = ''.obs;

  String get nickname => _nickname.value;
  String get imgUrl => _imgUrl.value;

  void setNickname(String name) {
    _nickname.value = name;
  }

  void setImgUrl(String url) {
    _imgUrl.value = url;
  }
}

class Token {
  String? accessToken, refreshToken;

  Token({this.accessToken, this.refreshToken});
}
