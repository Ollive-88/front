import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/board/board_api_service.dart';
import 'package:ollive_front/widgets/board/boardList_widget.dart';
import 'package:ollive_front/widgets/global/appbar_widget.dart';

class BoardScreen extends StatelessWidget {
  BoardScreen({super.key});

  final Future<List<BoardModel>> boards =
      BoardApiService.getBoardList("keyword", 0, 10);

  static final BoardModel board1 = BoardModel.fromJson({
    "title": "안녕하세요~ 간단한 용 잡아주실분 사례드릴게요",
    "boardId": 1,
    "viewCnt": 64,
    "likeCnt": 10,
    "commentCnt": 2,
    "tags": ["자유", "꿀팁"],
    "imgUrls": ["https://i.ytimg.com/vi/gpFSXXhonVk/maxresdefault.jpg"],
  });

  final List<BoardModel> boards2 = [board1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: CustomAppbar(
            title: "사람사는 이야기",
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: boards2.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              itemBuilder: (context, index) {
                var boardModel = boards2[index];

                return BoardList(boardModel: boardModel);
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: 40,
              ),
            )
          ],
        ));
  }
}

// FutureBuilder(
//         future: boards,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return Column(
//               children: [
//                 const SizedBox(
//                   height: 50,
//                 ),
//                 ListView.separated(
//                   scrollDirection: Axis.vertical,
//                   itemCount: snapshot.data!.length,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
//                   itemBuilder: (context, index) {
//                     var boardModel = snapshot.data![index];

//                     return BoardList(boardModel: boardModel);
//                   },
//                   separatorBuilder: (context, index) => const SizedBox(
//                     width: 40,
//                   ),
//                 )
//               ],
//             );
//           } else {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),