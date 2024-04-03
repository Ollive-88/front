import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeTag extends StatelessWidget {
  RecipeTag({
    super.key,
    required this.tagName,
    required this.isSelected,
    required this.select,
  });

  String tagName;
  bool isSelected;
  // ignore: prefer_typing_uninitialized_variables
  final select;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 5,
      ),
      child: OutlinedButton(
        style: ButtonStyle(
          side: MaterialStateProperty.resolveWith<BorderSide>((states) {
            if (isSelected) {
              return const BorderSide(color: Color(0xFF30AF98), width: 2.0);
            }
            return const BorderSide(color: Colors.black, width: 2.0);
          }),
        ),
        onPressed: () {
          select();
          isSelected = !isSelected;
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              // Flexible 또는 Expanded로 감쌀 수 있습니다.
              child: Text(
                tagName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
