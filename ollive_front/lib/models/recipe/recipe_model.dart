class RecipeModel {
  final String recipeId, title, thumbnail;

  RecipeModel.fromJson(Map<String, dynamic> json)
      : recipeId = json['recipeId'],
        title = json['title'],
        thumbnail = json['thumbnail'];
}
