class RecipeRequestModel {
  final List<String> likeTagNames;
  final List<String> hateTagNames;
  final int lastIndex, size;

  RecipeRequestModel(
      {required this.likeTagNames,
      required this.hateTagNames,
      required this.lastIndex,
      required this.size});
}
