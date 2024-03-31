import 'package:dio/dio.dart';
import 'package:ollive_front/models/user/user_model.dart';

final dio = Dio(BaseOptions(
  baseUrl: "http://j10a508.p.ssafy.io", // 위에서 실행시킨 스프링서버
  contentType: "application/json; charset=utf-8",
));

class UserService {
  Future<void> registerUser(SignIn input) async {
    Map<String, dynamic> requestBody = {
      'email': input.email,
      'password': input.password,
      'name': input.name,
      'birthday': input.birthday,
      'gender': input.gender,
    };

    try {
      Response response = await dio.post('/join', data: requestBody);
      print('회원가입 성공! ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<ResponseDTO> loginAction(Login input) async {
    FormData formData = FormData.fromMap({
      'email': input.email,
      'password': input.password,
    });

    try {
      Response response = await dio.post('/login', data: formData);

      ResponseDTO responseDTO = ResponseDTO.fromJson();
      // 토큰 받기
      final authorization = response.headers['Authorization'];
      final cookies = response.headers['Set-Cookie'];
      if (cookies != null) {
        final cookie = cookies.first;
        // 쿠키 문자열에서 리프레시 토큰 값을 파싱
        RegExp regExp = RegExp(r'Refresh=([^;]+)');
        Match? match = regExp.firstMatch(cookie);
        if (match != null) {
          String refreshToken = match.group(1)!;
          responseDTO.refreshToken = refreshToken;
        }
      }
      if (authorization != null) {
        responseDTO.token = authorization.first;
      }
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }
}
