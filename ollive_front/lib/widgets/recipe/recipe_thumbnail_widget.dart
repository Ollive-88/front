import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RecipeThumbnail extends StatelessWidget {
  RecipeThumbnail({super.key, required this.thumbnailUrl});

  String thumbnailUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(4, 3), // 그림자 위치
          ),
        ],
        borderRadius: BorderRadius.circular(30),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          // width: MediaQuery.of(context).size.width / 2.3,
          // height: MediaQuery.of(context).size.width / 2.3,
          thumbnailUrl,
          headers: const {
            "User-Agent":
                "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
          },
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
