import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
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
      await _dio.post('/api/v1/join', data: requestBody);
      return true;
    } catch (e) {
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
      Response response = await _dio.get('/api/v1/fridge-ingredients');
      for (var ingredient in response.data) {
        ingredientInstances.add(UserIngredients.fromJson(ingredient));
      }
      // ignore: empty_catches
    } catch (e) {}
    return ingredientInstances;
  }

  static Future<dynamic> postFridgeIngredients(UserIngredients input) async {
    Map<String, dynamic> requestBody = {
      'name': input.name,
      'endAt': input.endAt,
    };

    try {
      await _dio.post('/api/v1/fridge-ingredients', data: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> putFridgeIngredients(UserIngredients input) async {
    Map<String, dynamic> requestBody = {
      'name': input.name,
      'endAt': input.endAt,
    };
    try {
      await _dio.put('/api/v1/fridge-ingredients/${input.fridgeIngredientId}',
          data: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> deleteFridgeIngredients(int fridgeIngredientId) async {
    try {
      await _dio.delete('/api/v1/fridge-ingredients/$fridgeIngredientId');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<HateIngredients>> getDislikeIngredients() async {
    List<HateIngredients> ingredientInstances = [];
    try {
      Response response = await _dio.get('/api/v1/dislike-ingredients');
      for (var ingredient in response.data) {
        ingredientInstances.add(HateIngredients.fromJson(ingredient));
      }
      // ignore: empty_catches
    } catch (e) {}

    return ingredientInstances;
  }

  static Future<dynamic> postDislikeIngredients(String input) async {
    Map<String, dynamic> requestBody = {
      'name': input,
    };

    try {
      await _dio.post('/api/v1/dislike-ingredients', data: requestBody);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<dynamic> deleteDislikeIngredients(
      int dislikeIngredientId) async {
    try {
      await _dio.delete('/api/v1/dislike-ingredients/$dislikeIngredientId');
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<UserSimpleModel> getUserInfo() async {
    Response response = await _dio.get('/api/v1/memberinfo');
    return UserSimpleModel.fromJsonmypage(response.data);
  }

  static Future<dynamic> deleteUserInfo() async {
    await _dio.delete('/api/v1/memberinfo');
  }

  static Future<dynamic> updateUserInfo(List requestBody) async {
    FormData formData = FormData.fromMap({
      requestBody[0]: requestBody[1],
    });
    await _dio.patch('/api/v1/memberinfo', data: formData);
  }

  static Future<dynamic> convertXFileToMultipartFile(XFile? xFile) async {
    if (xFile == null) {
      return null;
    } else {
      File tempFile = File(xFile.path);
      MultipartFile multipartFile = await MultipartFile.fromFile(tempFile.path);

      return multipartFile;
    }
  }

  static Future<dynamic> updateProfileImage(List requestBody) async {
    if (requestBody[1] == null) {
      FormData formData = FormData();
      final reponse =
          await _dio.patch('/api/v1/member-profile-picture', data: formData);
      return reponse.data!['profileImage'];
    } else {
      FormData formData = FormData.fromMap({
        "profilePicture": requestBody[1],
      });
      final reponse =
          await _dio.patch('/api/v1/member-profile-picture', data: formData);
      return reponse.data!['profileImage'];
    }
  }

  static Future<dynamic> logoutAction() async {
    try {
      Response response = await _dio.post('/logout');
      if (response.statusCode == 302) {}
      // ignore: empty_catches
    } catch (e) {}
  }
}
