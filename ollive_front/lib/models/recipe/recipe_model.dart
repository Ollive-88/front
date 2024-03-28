class RecipeModel {
  final String title, thumbnail;
  final int recipeId;
  RecipeModel.fromJson(Map<String, dynamic> json)
      : recipeId = json['recipeId'],
        title = json['title'],
        thumbnail = json['thumbnail_url'];
}
