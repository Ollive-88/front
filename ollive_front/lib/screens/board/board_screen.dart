import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/screens/board/board_detil_screen.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/board/board_appbar_widget.dart';
import 'package:ollive_front/widgets/board/board_list_widget.dart';

// ignore: must_be_immutable
class BoardScreen extends StatefulWidget {
  BoardScreen({
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
  State<BoardScreen> createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int lastIndex = 0;
  int size = 10;

  // api 요청으로 받아온 게시글 목록
  late Future<List<BoardModel>> boards;

  // 스크롤 뷰에 스크롤 감지해서 앱바 지우기
  late ScrollController _scrollController;
  bool _isAppBarVisible = true;

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 3),
      curve: Curves.linear,
    );
  }

  void updateLastIndex(int index) {
    lastIndex = index;
  }

  void _fetchBoards() async {
    List<BoardModel> currentBoards = await boards;

    List<String> tagList = [];
    if (widget.tagNames != null) {
      for (var i = 0; i < widget.tagNames!.length; i++) {
        tagList.add(widget.tagNames![i].tagName);
      }
    }

    await BoardService.getBoardList(tagList, widget.keyword, lastIndex, size)
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

  @override
  void initState() {
    super.initState();

    List<String> tagList = [];
    if (widget.tagNames != null) {
      for (var i = 0; i < widget.tagNames!.length; i++) {
        tagList.add(widget.tagNames![i].tagName);
      }
    }

    boards =
        BoardService.getBoardList(tagList, widget.keyword, lastIndex, size);

    if (widget.boardScrollController == null) {
      // 컨트롤러 초기화 후 addListener로 동작 감지 설정
      _scrollController = ScrollController();
    } else {
      _scrollController = widget.boardScrollController!;
    }
    _scrollController.addListener(() {
      scrollListener();
    });
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
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      appBar: _isAppBarVisible
          ? AppBar(
              toolbarHeight: MediaQuery.of(context).size.height / 10,
              centerTitle: true,
              surfaceTintColor: const Color(0xFFFFFFFC),
              shadowColor: Colors.black,
              elevation: 0,
              backgroundColor: const Color(0xFFFFFFFC),
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
      body: FutureBuilder(
        future: boards,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/board/write');
        },
        child: SizedBox(
          width: 100,
          height: 45,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFD5D5),
              borderRadius: BorderRadius.circular(23),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  offset: const Offset(2, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 28,
                  ),
                  Text(
                    "글쓰기",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
