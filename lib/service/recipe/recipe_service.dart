import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class RecipeService {
  static final DioService _dio = DioService();

  // 레시피 추천 조회
  static Future<List<RecipeModel>> getRecommendRecipeList(
    List<String> havingIngredients,
    List<String>? dislikeIngredients,
  ) async {
    final response = await _dio.authDio.post(
      "/api/v1/recipes/recommendations",
      data: {
        "havingIngredients": havingIngredients,
        "dislikeIngredients": dislikeIngredients,
      },
    );
    final List<RecipeModel> recommendrecipes;

    recommendrecipes = (response.data).map<RecipeModel>((json) {
      return RecipeModel.fromJson(json);
    }).toList();

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
    final List<RecipeModel> recipes;

    if (recipeCategory == "전체") {
      recipeCategory = "";
    }

    final response = await _dio.authDio.post(
      "/api/v1/recipes",
      data: {
        "havingIngredients": havingIngredients,
        "dislikeIngredients": dislikeIngredients,
        "lastRecipeId": lastIndex,
        "size": size,
        "recipeCase": recipeCase,
        "recipeCategory": recipeCategory,
      },
    );

    recipes = (response.data).map<RecipeModel>((json) {
      return RecipeModel.fromJson(json);
    }).toList();

    return recipes;
  }

  // 레시피 상세 조회
  static Future<RecipeDetailModel> getRecipeDetail(int recipeId) async {
    RecipeDetailModel instance;
    final response = await _dio.authDio.get(
      "/api/v1/recipes/$recipeId",
    );

    instance = RecipeDetailModel.fromJson(response.data);

    return instance;
  }

  // 즐겨찾기 생성/삭제
  static void postFavorit(int recipeId) async {
    await _dio.authDio
        .post("/api/v1/recipes/scraps", data: {"recipeId": recipeId});
  }

  // 즐찾 레시피 조회
  static Future<List<RecipeModel>> getFavoirtRecipeList(
      int lastIndex, int size) async {
    final List<RecipeModel> recipes;

    final response = await _dio.authDio.get(
      "/api/v1/recipes/scraps",
      queryParameters: {
        "lastRecipeId": lastIndex,
        "size": size,
      },
    );

    recipes = (response.data).map<RecipeModel>((json) {
      return RecipeModel.fromJson(json);
    }).toList();

    return recipes;
  }

  // 별점 부여 생성/삭제
  static void postStar(int recipeId, int score) async {
    await _dio.authDio.post("/api/v1/recipes/scores", data: {
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
