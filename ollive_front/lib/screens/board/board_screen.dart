import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/widgets/board/board_list_widget.dart';
import 'package:ollive_front/widgets/global/appbar_widget.dart';

class BoardScreen extends StatelessWidget {
  BoardScreen({super.key});

  final Future<List<BoardModel>> boards =
      BoardService.getBoardList("keyword", 0, 10);

  static final BoardModel board1 = BoardModel.fromJson({
    "title": "안녕하세요~ 간단한 용 잡아주실분 사례드릴게요",
    "createdAt": '2024-01-15 04:28:03.339689',
    "boardId": 1,
    "viewCnt": 64,
    "likeCnt": 10,
    "commentCnt": 2,
    "tags": ["자유", "꿀팁"],
    "imgUrls": ["https://i.ytimg.com/vi/gpFSXXhonVk/maxresdefault.jpg"],
  });

  final List<BoardModel> boards2 = [
    board1,
    board1,
    board1,
    board1,
    board1,
    board1,
    board1,
    board1
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 7,
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Column(
          children: [
            Text(
              "사람사는 이야기",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            TextField(p)
          ],
        ),
        shape: const Border(
          bottom: BorderSide(
            width: 7,
            color: Color(0xFFEBEBE9),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: boards2.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              itemBuilder: (context, index) {
                var boardModel = boards2[index];

                return BoardList(boardModel: boardModel);
              },
              separatorBuilder: (context, index) {
                return const Column(
                  children: [
                    Divider(
                      thickness: 2,
                      height: 1,
                      color: Color(0xFFEEEEEC),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
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