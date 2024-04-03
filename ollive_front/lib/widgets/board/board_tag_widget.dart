import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/tag_model.dart';

// ignore: must_be_immutable
class Tag extends StatelessWidget {
  Tag({
    super.key,
    required this.tagModel,
    required this.isSearch,
    this.deleteTag,
  });

  TagModel tagModel;
  bool isSearch;
  // ignore: prefer_typing_uninitialized_variables
  final deleteTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 2,
        bottom: 2,
        left: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          7,
        ),
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            // Flexible 또는 Expanded로 감쌀 수 있습니다.
            child: Text(
              tagModel.tagName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Text(tagName),
          if (isSearch)
            IconButton(
              onPressed: deleteTag,
              icon: const Icon(
                size: 18,
                Icons.close_outlined,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            )
        ],
      ),
    );
  }
}
