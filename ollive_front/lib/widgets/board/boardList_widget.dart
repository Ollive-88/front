import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key, required this.boardModel});

  final BoardModel boardModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          const Column(),
          Column(children: [
            Hero(
              tag: boardModel.boardId,
              child: Container(
                width: 100,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        offset: const Offset(10, 10),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ]),
                child: Image.network(
                  boardModel.imgUrls[0],
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
