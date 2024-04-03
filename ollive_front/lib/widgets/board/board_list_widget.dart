import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/board/board_service.dart';

class BoardList extends StatelessWidget {
  const BoardList({super.key, required this.boardModel});

  final BoardModel boardModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 125,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목, 내용
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        boardModel.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        boardModel.content,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // 썸네일
                boardModel.thumbnailAddress != ""
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width / 5,
                        height: MediaQuery.of(context).size.width / 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15), // 여기서 borderRadius를 적용합니다.
                          child: Image.network(
                            boardModel.thumbnailAddress,
                            headers: const {
                              "User-Agent":
                                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${BoardService.timeAgo(boardModel.createdAt)} . 조회수 ${boardModel.views} . 좋아요 ${boardModel.likes}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF000000),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/image/icons/comentIcon.png",
                      width: 18,
                      height: 18,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${boardModel.commentCount}",
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
