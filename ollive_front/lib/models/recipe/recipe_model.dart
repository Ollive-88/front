import 'dart:ffi';

class RecipeModel {
  final Long recipeId;
  final String tltle, thumbnail;

  RecipeModel.fromJson(Map<String, dynamic> json)
      : recipeId = json['recipeId'],
        tltle = json['tltle'],
        thumbnail = json['thumbnail'];
}
