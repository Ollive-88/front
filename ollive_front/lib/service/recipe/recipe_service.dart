import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';
import 'package:ollive_front/util/error/error_service.dart';

class RecipeService {
  static final Dio _dio = DioService().authDio;

  // 레시피 추천 조회
  static Future<List<RecipeModel>> getRecommendRecipeList(
    List<String> havingIngredients,
    List<String>? dislikeIngredients,
  ) async {
    final List<RecipeModel> recommendrecipes = [];

    final response = await _dio.post(
      "/recipes/recommends",
      data: {
        "havingIngredients": havingIngredients,
        "dislikeIngredients": dislikeIngredients,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.data);

      for (var recipe in data) {
        recommendrecipes.add(RecipeModel.fromJson(recipe));
      }
    }

    return recommendrecipes;
  }

  // 레시피 조회
  static Future<List<RecipeModel>> getRecipeList(
      List<String> havingIngredients,
      List<String>? dislikeIngredients,
      String recipeCase,
      String recipeCategory,
      int lastIndex,
      int size) async {
    final List<RecipeModel> recipes = [];

    final response = await _dio.post(
      "/recipes",
      data: {
        "havingIngredients": havingIngredients,
        "dislikeIngredients": dislikeIngredients,
        "lastIndex": lastIndex,
        "size": size,
        "recipeCase": recipeCase,
        "recipeCategory": recipeCategory,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.data);

      for (var recipe in data) {
        recipes.add(RecipeModel.fromJson(recipe));
      }
    }

    return recipes;
  }

  // 레시피 상세 조회
  static Future<RecipeDetailModel> getRecipeDetail(String recipeId) async {
    final response = await _dio.post(
      "/recipes/$recipeId",
    );

    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.data);

      final instance = RecipeDetailModel.fromJson(data);

      return instance;
    }

    ErrorService.showToast(response.data.masege);

    throw Error();
  }

  // 즐겨찾기 생성/삭제
  static void postFavorit(int recipeId) async {
    await _dio.post("recipes/favorit", data: {"recipeId": recipeId});
  }

  // 별점 부여 생성/삭제
  static void postStar(int recipeId, int score) async {
    await _dio.post("recipes/star", data: {
      "recipeId": recipeId,
      "score": score,
    });
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
