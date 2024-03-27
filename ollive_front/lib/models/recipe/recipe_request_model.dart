class RecipeRequestModel {
  final List<String> havingIngredients;
  final List<String>? dislikeIngredients;
  final int lastIndex, size;

  RecipeRequestModel(
      {required this.havingIngredients,
      required this.dislikeIngredients,
      required this.lastIndex,
      required this.size});
}
