import 'package:flutter/cupertino.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';

class RecipeListScreen extends StatelessWidget {
  const RecipeListScreen({
    super.key,
    required this.likeTagNames,
    required this.hateTagNames,
    required this.lastIndex,
    required this.size,
  });

  final List<String> likeTagNames;
  final List<String> hateTagNames;
  final int lastIndex, size;
  // String recipeCase, recipeKa;

  // Future<List<RecipeModel>> recipes;
  // RecipeService.getRecipeList(
  //   likeTagNames,
  //   hateTagNames,
  //   0,
  //   10,
  // );
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
