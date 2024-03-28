import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/models/board/board_post_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class BoardService {
  static final Dio _dio = DioService().authDio;

  // 게시글 조회
  static Future<dynamic> getBoardList(
      List<String>? tags, String? keyword, int lastIndex, int size) async {
    final List<BoardModel> boards = [];

    try {
      final Response response;
      if (keyword == null) {
        response = await _dio.get(
          "/api/v1/boards",
          queryParameters: {
            "lastIndex": lastIndex,
            "size": size,
          },
        );
      } else {
        response = await _dio.get(
          "/api/v1/boards",
          queryParameters: {
            "tags": tags,
            "keyword": keyword,
            "lastIndex": lastIndex,
            "size": size,
          },
        );
      }

      print(response);

      List<dynamic> data = jsonDecode(response.data);

      for (var board in data) {
        boards.add(BoardModel.fromJson(board));
      }

      return boards;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  // 게시글 생성
  static Future<int> postBoard(BoardPostModel boardPostModel) async {
    final response = await _dio.post(
      "/boards",
      queryParameters: {
        "post": boardPostModel,
      },
    );

    if (response.statusCode == 200) {
      int instance = jsonDecode(response.data.boardId);
      return instance;
    }
    throw Error();
  }

  // 게시글 수정
  static Future<int> fatchBoard(BoardPostModel boardPostModel) async {
    final response = await _dio.put(
      "/boards",
      queryParameters: {
        "fetch": boardPostModel,
      },
    );

    if (response.statusCode == 200) {
      int instance = jsonDecode(response.data.boardId);
      return instance;
    }
    throw Error();
  }

  // 게시글 상세 조회
  static Future<BoardDetailModel> getBoardDetail(int boardId) async {
    final response = await _dio.post(
      "/boards/$boardId",
    );

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.data);

      final instance = BoardDetailModel.fromJson(data);

      return instance;
    }

    throw Error();
  }

  // 게시글 삭제
  static Future<int> deleteBoard(int boardId) async {
    final response =
        await _dio.post("boards", queryParameters: {"boardId": boardId});
    return response.statusCode!;
  }

  // 좋아요 생성/삭제
  static void postLike(int boardId, bool isLiked) async {
    await _dio.post("boards",
        queryParameters: {"boardId": boardId, "isLiked": isLiked});
  }

  // 시간 계산
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
