import 'package:dio/dio.dart';
import 'package:ollive_front/models/user/user_model.dart';

final dio = Dio(BaseOptions(
  baseUrl: "http://j10a508.p.ssafy.io:8080", // 위에서 실행시킨 스프링서버
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
      'role': input.role,
    };
    try {
      Response response = await dio.post('/join', data: requestBody);
      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (e) {
      print('Error: $e');
    }
  }
}
