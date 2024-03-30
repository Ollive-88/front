import 'package:flutter/material.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';

// ignore: must_be_immutable
class RecipeScore extends StatelessWidget {
  RecipeScore({super.key, required this.recipeId, required this.score});

  int recipeId;
  double score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              for (int i = 0; i < score.toInt(); i++)
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "assets/image/icons/star_fullIcon.png",
                      ),
                      onPressed: () {
                        RecipeService.postStar(recipeId, i);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              for (int i = 0; i < 5 - score.toInt(); i++)
                Row(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        "assets/image/icons/star_emptyIcon.png",
                      ),
                      onPressed: () {
                        RecipeService.postStar(recipeId, i);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
            ],
          ),
          Text(
            score.toString(),
            style: const TextStyle(
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
