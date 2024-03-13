import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/dio/dio_service.dart';

class BoardApiService {
  final Dio _dio = DioServices().to();

  Future<List<Board>> getBoardList(String keyword, int page, int size) async {
    final List<Board> boards = [];

    final response = await _dio.get('path');
    List<dynamic> data = jsonDecode(response.data);

    for (var board in data) {
      boards.add(Board.fromJson(board));
    }

    return boards;
  }
}
