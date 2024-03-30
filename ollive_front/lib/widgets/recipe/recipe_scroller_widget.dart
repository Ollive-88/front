import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeScrollerButton extends StatefulWidget {
  RecipeScrollerButton({super.key, required this.controller});

  ScrollController controller = ScrollController();

  @override
  State<RecipeScrollerButton> createState() => _RecipeScrollerButtonState();
}

class _RecipeScrollerButtonState extends State<RecipeScrollerButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        widget.controller.animateTo(0,
            duration: const Duration(microseconds: 300),
            curve: Curves.bounceIn);
      },
      backgroundColor: const Color(0xFF30AF98),
      child: const Icon(
        Icons.arrow_upward,
        size: 28,
      ),
    );
  }
}
