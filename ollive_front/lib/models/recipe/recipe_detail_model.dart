class RecipeDetailModel {
  String recipeId, title, thumbnailUrl, amount, time, difficulty;
  double score;
  List<IngredientModel> ingredients;
  List<ProcesseModel> processes;

  RecipeDetailModel.fromJson(Map<String, dynamic> json)
      : recipeId = json["id"],
        title = json['title'],
        thumbnailUrl = json['thumbnail_url'],
        amount = json['amount'],
        time = json['time'],
        difficulty = json['difficulty'],
        score = json['score'],
        ingredients = (json['ingredients'] as List<dynamic>)
            .map((ingredient) => IngredientModel.fromJson(ingredient))
            .toList(),
        processes = (json['processes'] as List<dynamic>)
            .map((processe) => ProcesseModel.fromJson(processe))
            .toList();
}

class IngredientModel {
  String name, amount;

  IngredientModel.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        amount = json['amount'];
}

class ProcesseModel {
  String content, imageUrl;
  int cookOrder;

  ProcesseModel.fromJson(Map<String, dynamic> json)
      : content = json["content"],
        imageUrl = json['imageUrl'],
        cookOrder = json['cookOrder'];
}
