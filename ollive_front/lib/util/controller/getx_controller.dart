import 'package:get/get.dart';

class StatusController extends GetxController {
  Token _token = Token();

  Token get token => _token;

  void setToken(Token newToken) {
    _token = newToken;
  }
}

class Token {
  String? accessToken, refreshToken;

  Token({this.accessToken, this.refreshToken});
}
