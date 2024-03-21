import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class BoardImage extends StatelessWidget {
  BoardImage(
      {super.key, required this.heght, required this.image, this.deleteImage});

  double heght;
  XFile image;
  // ignore: prefer_typing_uninitialized_variables
  final deleteImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: heght,
          height: heght,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(File(image.path)),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        // 삭제 버튼
        Positioned(
          right: -15, // 우측 상단에 조금 튀어나오게 조정
          top: -15, // 상단에 조금 튀어나오게 조정
          child: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.red),
            onPressed: deleteImage,
          ),
        ),
      ],
    );
  }
}
