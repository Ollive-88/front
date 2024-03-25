import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/models/board/board_post_model.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/models/recipe/recipe_request_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class RecipeService {
  static final Dio _dio = DioService().authDio;

  // 레시피 조회
  static Future<List<RecipeModel>> getRecipeList(List<String> likeTagNames,
      List<String> hateTagNames, int lastIndex, int size) async {
    final List<RecipeModel> boards = [];

    RecipeRequestModel request = RecipeRequestModel(
      likeTagNames: likeTagNames,
      hateTagNames: hateTagNames,
      lastIndex: lastIndex,
      size: size,
    );

    final response = await _dio.post(
      "/recipes",
      data: {
        "request": request,
      },
    );

    List<dynamic> data = jsonDecode(response.data);

    for (var recipe in data) {
      boards.add(RecipeModel.fromJson(recipe));
    }

    return boards;
  }

  // 게시글 상세 조회
  static Future<BoardDetailModel> getBoardDetail(int recipeId) async {
    final response = await _dio.post(
      "/recipes/$recipeId",
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
