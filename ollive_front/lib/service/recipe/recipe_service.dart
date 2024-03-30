import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';
import 'package:ollive_front/util/error/error_service.dart';

class RecipeService {
  static final DioService _dio = DioService();

  // 레시피 추천 조회
  static Future<List<RecipeModel>> getRecommendRecipeList(
    List<String> havingIngredients,
    List<String>? dislikeIngredients,
  ) async {
    try {
      final response = await _dio.authDio.post(
        "/recipes/recommendations",
        data: {
          "havingIngredients": havingIngredients,
          "dislikeIngredients": dislikeIngredients,
        },
      );
      final List<RecipeModel> recommendrecipes;

      if (response.statusCode == 200) {
        recommendrecipes = (response.data).map<RecipeModel>((json) {
          return RecipeModel.fromJson(json);
        }).toList();
      } else {
        recommendrecipes = [];
      }

      return recommendrecipes;
    } catch (e) {
      print(e);
      throw Error();
    }
  }

  // 레시피 조회
  static Future<List<RecipeModel>> getRecipeList(
      List<String> havingIngredients,
      List<String>? dislikeIngredients,
      String recipeCase,
      String recipeCategory,
      int lastIndex,
      int size) async {
    final List<RecipeModel> recipes;

    if (recipeCategory == "전체") {
      recipeCategory = "";
    }

    // print("좋재 : $havingIngredients");
    // print("실재 : $dislikeIngredients");
    // print("대분 : $recipeCase");
    // print("소분 : $recipeCategory");
    // print("라인 : $lastIndex");
    // print("사이 : $size");

    try {
      final response = await _dio.authDio.post(
        "/recipes",
        data: {
          "havingIngredients": havingIngredients,
          "dislikeIngredients": dislikeIngredients,
          "lastRecipeId": lastIndex,
          "size": size,
          "recipeCase": recipeCase,
          "recipeCategory": recipeCategory,
        },
      );

      if (response.statusCode == 200) {
        recipes = (response.data).map<RecipeModel>((json) {
          return RecipeModel.fromJson(json);
        }).toList();
      } else {
        recipes = [];
      }
      return recipes;
    } catch (e) {
      ErrorService.showToast("잘못된 요청입니다.");

      throw Error();
    }
  }

  // 레시피 상세 조회
  static Future<RecipeDetailModel> getRecipeDetail(int recipeId) async {
    try {
      RecipeDetailModel instance;
      final response = await _dio.authDio.get(
        "/recipes/$recipeId",
      );

      instance = RecipeDetailModel.fromJson(response.data);

      return instance;
    } catch (e) {
      throw Error();
    }
  }

  // 즐겨찾기 생성/삭제
  static void postFavorit(int recipeId) async {
    await _dio.authDio.post("recipes/favorit", data: {"recipeId": recipeId});
  }

  // 별점 부여 생성/삭제
  static void postStar(int recipeId, int score) async {
    await _dio.authDio.post("recipes/star", data: {
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
