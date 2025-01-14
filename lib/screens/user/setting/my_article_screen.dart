import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/screens/board/board_detil_screen.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/board/board_list_widget.dart';

// ignore: must_be_immutable
class MyArticleScreen extends StatefulWidget {
  MyArticleScreen({
    super.key,
    this.tagNames,
    this.keyword,
    this.boardScrollController,
  });

  // 검색할 태그 목록
  final List<TagModel>? tagNames;
  // 검색어
  final String? keyword;

  ScrollController? boardScrollController = ScrollController();

  @override
  State<MyArticleScreen> createState() => _MyArticleScreenState();
}

class _MyArticleScreenState extends State<MyArticleScreen> {
  int lastIndex = 0;
  int size = 10;
  bool isMyView = true;

  // api 요청으로 받아온 게시글 목록
  late Future<List<BoardModel>> boards;

  // 스크롤 뷰에 스크롤 감지해서 앱바 지우기
  late ScrollController _scrollController;

  void updateLastIndex(int index) {
    lastIndex = index;
  }

  void _fetchBoards() async {
    List<BoardModel> currentBoards = await boards;

    List<String> tagList = [];

    await BoardService.getMyBoardList(tagList, lastIndex, size, isMyView)
        .then((value) {
      if (value.isNotEmpty) {
        setState(() {
          currentBoards.addAll(value);
          boards = Future.value(currentBoards);
        });
      } else {
        ErrorService.showToast("마지막 게시물 입니다.");
      }
    }).catchError((onError) {
      ErrorService.showToast("잘못된 요청입니다.");
    });
  }

  void scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _fetchBoards();
    }
  }

  void addLike(int i, bool isLiked) async {
    List<BoardModel> currntBoard = await boards;
    if (isLiked) {
      currntBoard[i].likes++;
    } else {
      currntBoard[i].likes--;
    }

    boards = Future.value(currntBoard);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    List<String> tagList = [];

    boards = BoardService.getMyBoardList(tagList, lastIndex, size, isMyView);

    if (widget.boardScrollController == null) {
      // 컨트롤러 초기화 후 addListener로 동작 감지 설정
      _scrollController = ScrollController();
    } else {
      _scrollController = widget.boardScrollController!;
    }
    _scrollController.addListener(() {
      scrollListener();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose(); // ScrollController를 정리
    super.dispose();
  }

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFFFD5D5),
    minimumSize: const Size(0, 50),
    foregroundColor: Colors.black,
    textStyle: const TextStyle(
      fontSize: 18,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 게시글'),
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
      ),
      // 이거 Future Builder로 만들어야함!
      body: FutureBuilder(
        future: boards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (snapshot.data!.isNotEmpty)
                ? ListView.separated(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    itemBuilder: (context, index) {
                      var boardModel = snapshot.data![index];
                      updateLastIndex(boardModel.boardId);
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BoardDetailScreen(
                                  boardId: boardModel.boardId,
                                  index: index,
                                  addLike: addLike,
                                ),
                              ),
                            );
                          },
                          child: BoardList(boardModel: boardModel));
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
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('첫 게시글을 등록해보세요.'),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/home', (route) => false);
                          },
                          style: buttonStyle,
                          child: const Text(
                            '게시판으로 이동',
                          ),
                        ),
                      ],
                    ),
                  );
          } else {
            return const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFFFFFFFC),
                backgroundImage: AssetImage("./assets/image/loding/Loding.gif"),
                radius: 60,
              ),
            );
          }
        },
      ),
    );
  }
}
