import 'dart:async';

import 'package:flutter/material.dart';

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
  final FocusNode _fcusNode = FocusNode();

  // 태그 입력 처리 메서드
  void subStringTags() {
    String text = _inputController.text;
    RegExp regExp = RegExp(r"[\uAC00-\uD7A3a-zA-Z0-9_]+");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    for (var match in matches) {
      text = text.replaceFirst(match.group(0)!, '');
      widget.ingredients.add(match.group(0)!);
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _inputController.text = text.trim(); // trim()을 사용해 앞뒤 공백 제거
    });

    Timer(const Duration(milliseconds: 100), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });

    setState(() {});
  }

  // 태그 지우는 메서드
  void deleteTags(int index, List<String> tagNames) {
    tagNames.removeAt(index);
    setState(() {});
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
      // ignore: deprecated_member_use
      child: RawKeyboardListener(
        focusNode: _fcusNode,
        onKey: (event) {
          if (event.physicalKey.debugName == "Space") {
            subStringTags();
          }
        },
        child: TextField(
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
                            tagName: widget.ingredients[i],
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
      ),
    );
  }
}
