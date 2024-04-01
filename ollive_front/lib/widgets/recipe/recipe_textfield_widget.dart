import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/tag_model.dart';

import '../board/board_tag_widget.dart';

// ignore: must_be_immutable
class RecipeTextField extends StatefulWidget {
  RecipeTextField({super.key, required this.ingredients});

  List<String> ingredients;

  @override
  State<RecipeTextField> createState() => _RecipeTextFieldState();
}

class _RecipeTextFieldState extends State<RecipeTextField> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _handleInput(String input) {
    if (input.endsWith(' ')) {
      String ingredient = input.trim();
      if (ingredient.isNotEmpty) {
        setState(() {
          widget.ingredients.add(ingredient);
          _inputController.clear();
        });
        Timer(const Duration(milliseconds: 50), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        });
      }
    }
  }

  // 태그 지우는 메서드
  void deleteTags(int index, List<String> tagNames) {
    tagNames.removeAt(index);
    setState(() {});
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFF30AF98),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFFEBEBE9)),
      child: TextField(
        onChanged: _handleInput,
        controller: _inputController,
        decoration: InputDecoration(
          border: InputBorder.none,
          // ignore: sized_box_for_whitespace
          prefixIcon: Container(
            constraints: const BoxConstraints(maxWidth: 280),
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var i = 0; i < widget.ingredients.length; i++)
                    Row(
                      children: [
                        Tag(
                          tagModel: TagModel(widget.ingredients[i]),
                          isSearch: true,
                          deleteTag: () => deleteTags(i, widget.ingredients),
                        ),
                        const SizedBox(
                          width: 5,
                        )
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
