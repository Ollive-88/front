import 'package:flutter/widgets.dart';
import 'package:ollive_front/models/recipe/recipe_detail_model.dart';

// ignore: must_be_immutable
class RecipeIngredient extends StatelessWidget {
  RecipeIngredient({super.key, required this.ingredient, required this.isEnd});

  IngredientModel ingredient;
  bool isEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          decoration: !isEnd
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2,
                      color: Color(0xFFEEEEEC),
                    ),
                  ),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ingredient.name,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                ingredient.amount,
                style: const TextStyle(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
