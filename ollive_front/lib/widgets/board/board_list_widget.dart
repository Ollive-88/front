import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key, required this.boardModel});

  final BoardModel boardModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 해쉬 태그 들어갈 자리
                  Row(
                    children: [
                      for (var tag in boardModel.tags)
                        Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Tag(tagName: tag, isSearch: false),
                        )
                    ],
                  ),
                  Text(
                    boardModel.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${BoardService.timeAgo(boardModel.createdAt)} . 조회수 ${boardModel.viewCnt} . 좋아요 ${boardModel.likeCnt}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  height: MediaQuery.of(context).size.width / 5,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(15), // 여기서 borderRadius를 적용합니다.
                    child: Image.network(
                      boardModel.imgUrls[0],
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                      },
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/image/icons/comentIcon.png",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${boardModel.commentCnt}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
