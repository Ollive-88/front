import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/widgets/board/board_appbar_widget.dart';
import 'package:ollive_front/widgets/board/board_list_widget.dart';

class BoardScreen extends StatefulWidget {
  const BoardScreen({super.key, this.tagNames, this.keyword});
  // 검색할 태그 목록
  final List<String>? tagNames;
  // 검색어
  final String? keyword;

  // Todo : 나중에 지우기
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

  @override
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  // Todo : 나중에 지우기
  final List<BoardModel> boards2 = [
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1,
    BoardScreen.board1
  ];

  // api 요청으로 받아온 게시글 목록
  late Future<List<BoardModel>> boards;

  // 스크롤 뷰에 스크롤 감지해서 앱바 지우기
  late ScrollController _scrollController;
  bool _isAppBarVisible = true;

  @override
  void initState() {
    super.initState();
    boards = BoardService.getBoardList(widget.tagNames, widget.keyword, 0, 10);

    // 컨트롤러 초기화 후 addListener로 동작 감지 설정
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      // 스크롤 위치에 따라 AppBar의 표시 여부를 결정
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isAppBarVisible) {
          setState(() {
            _isAppBarVisible = false; // 스크롤을 내릴 때 AppBar 숨김
          });
        }
      } else {
        if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (!_isAppBarVisible) {
            setState(() {
              _isAppBarVisible = true; // 스크롤을 올릴 때 AppBar 표시
            });
          }
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController를 정리
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        appBar: _isAppBarVisible
            ? AppBar(
                toolbarHeight: MediaQuery.of(context).size.height / 10,
                centerTitle: true,
                surfaceTintColor: const Color(0xFFFFFFFC),
                shadowColor: Colors.black,
                elevation: 0,
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                title: BoardAppBar(keyword: widget.keyword),
                shape: const Border(
                  bottom: BorderSide(
                    width: 7,
                    color: Color(0xFFEBEBE9),
                  ),
                ),
              )
            : null,
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                scrollDirection: Axis.vertical,
                itemCount: boards2.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
// 
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