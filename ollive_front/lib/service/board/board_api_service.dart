import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class BoardApiService {
  final Dio _dio = DioService().authDio;

  Future<List<Board>> getBoardList(String keyword, int page, int size) async {
    final List<Board> boards = [];

    final response = await _dio.get("/swignsing", queryParameters: {});
    List<dynamic> data = jsonDecode(response.data);

    for (var board in data) {
      boards.add(Board.fromJson(board));
    }

    return boards;
  }
}
