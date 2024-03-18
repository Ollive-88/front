import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class BoardService {
  static final Dio _dio = DioService().authDio;

  static Future<List<BoardModel>> getBoardList(
      List<String>? tags, String? keyword, int page, int size) async {
    final List<BoardModel> boards = [];

    final response = await _dio.get("/swignsing", queryParameters: {});
    List<dynamic> data = jsonDecode(response.data);

    for (var board in data) {
      boards.add(BoardModel.fromJson(board));
    }

    return boards;
  }

  static String timeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return "$years년 전";
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return "$months달 전";
    } else if (difference.inDays >= 1) {
      return "${difference.inDays}일 전";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours}시간 전";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes}분 전";
    } else {
      return "${difference.inSeconds}초 전";
    }
  }
}
