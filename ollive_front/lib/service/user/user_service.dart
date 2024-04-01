import 'package:dio/dio.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/models/user/user_simple_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class UserService {
  static final Dio _dio = DioService().authDio;

  static Future<bool> registerUser(SignIn input) async {
    Map<String, dynamic> requestBody = {
      'email': input.email,
      'password': input.password,
      'name': input.name,
      'birthday': input.birthday,
      'gender': input.gender,
    };

    try {
      await _dio.post('/join', data: requestBody);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<ResponseDTO> loginAction(Login input) async {
    FormData formData = FormData.fromMap({
      'email': input.email,
      'password': input.password,
    });

    try {
      Response response = await _dio.post('/login', data: formData);

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
        responseDTO.accessToken = authorization.first;
      }
      return responseDTO;
    } catch (e) {
      return ResponseDTO(code: -1, msg: "유저네임 혹은 비번이 틀렸습니다");
    }
  }

  static Future<List<UserIngredients>> getFridgeIngredients() async {
    List<UserIngredients> ingredientInstances = [];
    try {
      Response response = await _dio.get('/fridge-ingredients');
      for (var ingredient in response.data) {
        ingredientInstances.add(UserIngredients.fromJson(ingredient));
      }
    } catch (e) {
      print('$e');
    }
    return ingredientInstances;
  }

  static Future<dynamic> postFridgeIngredients(UserIngredients input) async {
    Map<String, dynamic> requestBody = {
      'name': input.name,
      'endAt': input.endAt,
    };

    try {
      await _dio.post('/fridge-ingredients', data: requestBody);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<dynamic> putFridgeIngredients(UserIngredients input) async {
    Map<String, dynamic> requestBody = {
      'name': input.name,
      'endAt': input.endAt,
    };
    print(requestBody);
    try {
      await _dio.put('/fridge-ingredients/${input.fridgeIngredientId}',
          data: requestBody);
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<dynamic> deleteFridgeIngredients(int fridgeIngredientId) async {
    try {
      await _dio.delete('/fridge-ingredients/$fridgeIngredientId');
      return true;
    } catch (e) {
      print('Error: $e');
      return false;
    }
  }

  static Future<List<HateIngredients>> getDislikeIngredients() async {
    List<HateIngredients> ingredientInstances = [];
    try {
      Response response = await _dio.get('/dislike-ingredients');
      for (var ingredient in response.data) {
        ingredientInstances.add(HateIngredients.fromJson(ingredient));
      }
    } catch (e) {}

    return ingredientInstances;
  }

  static Future<dynamic> postDislikeIngredients(String input) async {
    Map<String, dynamic> requestBody = {
      'name': input,
    };

    try {
      await _dio.post('/dislike-ingredients', data: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> deleteDislikeIngredients(
      int dislikeIngredientId) async {
    try {
      await _dio.delete('/dislike-ingredients/$dislikeIngredientId');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<UserSimpleModel> getUserInfo() async {
    Response response = await _dio.get('/memberinfo');
    return UserSimpleModel.fromJsonmypage(response.data);
  }
}
