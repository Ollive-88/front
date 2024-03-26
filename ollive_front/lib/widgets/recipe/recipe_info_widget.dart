import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class RecipeInfo extends StatelessWidget {
  RecipeInfo({super.key, required this.iconUrl, required this.text});

  String iconUrl, text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconUrl,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }
}
