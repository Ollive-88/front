import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class BoardApiService {
  static final Dio _dio = DioService().authDio;

  static Future<List<BoardModel>> getBoardList(
      String keyword, int page, int size) async {
    final List<BoardModel> boards = [];

    final response = await _dio.get("/swignsing", queryParameters: {});
    List<dynamic> data = jsonDecode(response.data);

    for (var board in data) {
      boards.add(BoardModel.fromJson(board));
    }

    return boards;
  }
}
