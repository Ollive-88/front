import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class RecipeDifficulty extends StatelessWidget {
  RecipeDifficulty({super.key, required this.difficulty});

  String difficulty;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              "assets/image/icons/star_fullIcon.png",
            ),
            Image.asset(
              difficulty == "중급" || difficulty == "고급"
                  ? "assets/image/icons/star_fullIcon.png"
                  : "assets/image/icons/star_emptyIcon.png",
            ),
            Image.asset(
              difficulty == "고급"
                  ? "assets/image/icons/star_fullIcon.png"
                  : "assets/image/icons/star_emptyIcon.png",
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          difficulty,
          style: const TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
