import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class RecipeScore extends StatelessWidget {
  RecipeScore({super.key, required this.score});

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
                    Image.asset(
                      "assets/image/icons/star_fullIcon.png",
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              for (int i = 0; i < 5 - score.toInt(); i++)
                Row(
                  children: [
                    Image.asset(
                      "assets/image/icons/star_emptyIcon.png",
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
