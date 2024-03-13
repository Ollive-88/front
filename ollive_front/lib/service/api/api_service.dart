import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiService {
  var dio = Dio();
  static const String baseUrl = "";

  // static Future<List<dynamic>> get(String path) async {
  // final url = Uri.parse();

  // final response = await dio.get('$baseUrl/$path');
  // if (response.statusCode == 200) {
  //   final instance = jsonDecode(response.body);
  //   return instance;
  // }
  // throw Error();
  // }

  static Future<dynamic> post(String path) async {
    final url = Uri.parse('$baseUrl/$path');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final instance = jsonDecode(response.body);
      return instance;
    }
    throw Error();
  }
}
