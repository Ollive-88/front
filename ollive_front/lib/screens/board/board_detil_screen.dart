import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/screens/board/board_write_screen.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

// ignore: must_be_immutable
class BoardDetailScreen extends StatefulWidget {
  const BoardDetailScreen({super.key, required this.boardId});

  final int boardId;

  @override
  State<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  BoardDetailModel boardDetail1 = BoardDetailModel.fromJson({
    "title": "안녕하세요~ 간단한 용 잡아주실분 사례드릴게요",
    "content":
        "미안하다 이거 보여주려고 어그로끌었다.. 나루토 사스케 싸움수준 ㄹㅇ실화냐? 진짜 세계관최강자들의 싸움이다.. 그찐따같던 나루토가 맞나? 진짜 나루토는 전설이다..진짜옛날에 맨날나루토봘는데 왕같은존재인 호카게 되서 세계최강 전설적인 영웅이된나루토보면 진짜내가다 감격스럽고 나루토 노래부터 명장면까지 가슴울리는장면들이 뇌리에 스치면서 가슴이 웅장해진다.. 그리고 극장판 에 카카시앞에 운석날라오는 거대한 걸 사스케가 갑자기 순식간에 나타나서 부숴버리곤 개간지나게 나루토가 없다면 마을을 지킬 자는 나밖에 없다 라며 바람처럼 사라진장면은 진짜 나루토처음부터 본사람이면 안울수가없더라 진짜 너무 감격스럽고 보루토를 최근에 알았는데 미안하다.. 지금20화보는데 진짜 나루토세대나와서 너무 감격스럽고 모두어엿하게 큰거보니 내가 다 뭔가 알수없는 추억이라해야되나 그런감정이 이상하게 얽혀있다.. 시노는 말이많아진거같다 좋은선생이고..그리고 보루토왜욕하냐 귀여운데 나루토를보는것같다 성격도 닮았어 그리고버루토에 나루토사스케 둘이싸워도 이기는 신같은존재 나온다는게 사실임?? 그리고인터닛에 쳐봣는디 이거 ㄹㅇㄹㅇ 진짜팩트냐?? 저적이 보루토에 나오는 신급괴물임?ㅡ 나루토사스케 합체한거봐라 진짜 ㅆㅂ 이거보고 개충격먹어가지고 와 소리 저절로 나오더라 ;; 진짜 저건 개오지는데.. 저게 ㄹㅇ이면 진짜 꼭봐야돼 진짜 세계도 파괴시키는거아니야 .. 와 진짜 나루토사스케가 저렇게 되다니 진짜 눈물나려고했다.. 버루토그라서 계속보는중인데 저거 ㄹㅇ이냐..? 하.. ㅆㅂ 사스케 보고싶다..  진짜언제 이렇게 신급 최강들이 되었을까 옛날생각나고 나 중딩때생각나고 뭔가 슬프기도하고 좋기도하고 감격도하고 여러가지감정이 복잡하네.. 아무튼 나루토는 진짜 애니중최거명작임..",
    "createdAt": '2024-01-15 04:28:03.339689',
    "boardId": 1,
    "viewCnt": 64,
    "likeCnt": 10,
    "commentCnt": 3,
    "isLiked": true,
    "isMine": true,
    "writer": {
      "nickName": "난밤이야슈밤",
      "imgUrl":
          "https://talkimg.imbc.com/TVianUpload/tvian/TViews/image/2022/09/18/1e586277-48ba-4e8a-9b98-d8cdbe075d86.jpg",
    },
    "tags": [
      "자유자유",
      "꿀팁꿀팁",
      "꿀팁꿀팁",
      "꿀팁꿀팁",
      "꿀팁꿀팁",
    ],
    "imgUrls": [
      "https://pbs.twimg.com/media/ET-HnKfUcAAUs01.jpg",
      "https://i.ytimg.com/vi/gpFSXXhonVk/maxresdefault.jpg",
    ],
    "comments": [
      {
        "content": "진짜 어그로 개쩐다",
        "createdAt": "2024-03-15 04:28:03.339689",
        "writer": {
          "nickName": "시원한시밤",
          "imgUrl":
              "https://i.ytimg.com/vi/wVu1IeLXzyY/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGEMgSShyMA8=&rs=AOn4CLAxpBq_M3zqiezJPNDSQbj-zRppqg",
        },
      },
      {
        "content": "시발련아",
        "createdAt": "2024-02-15 04:28:03.339689",
        "writer": {
          "nickName": "굼바",
          "imgUrl":
              "https://i.namu.wiki/i/rOfNmCRWha9_Dr-mZLqLLqfSmIjSfDfuebDGkFvy0INx55a1BWH6WlbrGB2FetYusJa4Y7EkqiuzOCEQYXKjpA.webp",
        },
      },
      {
        "content": "ㄹㅇㅋㅋ",
        "createdAt": "2024-02-15 04:28:03.339689",
        "writer": {
          "nickName": "다이노굼바",
          "imgUrl":
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBIoOgEns2UxY29rIn2ymf8lYKbMSPebu31w&usqp=CAU"
        },
      }
    ]
  });

  late Future<BoardDetailModel> boardDetail;

  @override
  void initState() {
    super.initState();
    boardDetail = BoardService.getBoardDetail(widget.boardId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: const Border(
          bottom: BorderSide(
            width: 7,
            color: Color(0xFFEBEBE9),
          ),
        ),
        title: boardDetail1.isMine
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFFFFC),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                              ),
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BoardWriteScreen(
                                          boadrDetail: boardDetail1,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      "수정",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                  height: 1,
                                  color: Color(0xFFEBEBE9),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Future<int> response =
                                        BoardService.deleteBoard(
                                            boardDetail1.boardId);
                                    if (response == 200) {
                                      Navigator.pop(context);
                                    } else {
                                      // Todo : 오류 모달 생성
                                    }
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    child: Text(
                                      "삭제",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              )
            : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  // 글쓴이, 작성시간
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFEBEBE9),
                          width: 2,
                        ),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.network(
                            boardDetail1.writer.imgUrl,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.width / 6,
                            headers: const {
                              "User-Agent":
                                  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                            },
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                boardDetail1.writer.nickName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                BoardService.timeAgo(boardDetail1.createdAt),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //제목
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Text(
                      boardDetail1.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // 이미지
                  Container(
                    decoration: const BoxDecoration(),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enableInfiniteScroll: false,
                      ),
                      items: boardDetail1.imgUrls
                          .map(
                            (imgUrl) => Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10), // 여기에 마진 추가

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height:
                                      MediaQuery.of(context).size.width / 1.1,
                                  imgUrl,
                                  headers: const {
                                    "User-Agent":
                                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                  },
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  // 본문
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                    ),
                    child: Text(
                      boardDetail1.content,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // 태그
                  Column(
                    children: [
                      Wrap(
                        spacing: 8.0, // 가로 방향의 태그 사이 간격
                        runSpacing: 4.0,
                        children: [
                          for (var tag in boardDetail1.tags)
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: Tag(tagName: tag, isSearch: false),
                            )
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // 뷰카운트, 라이크카운트
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 30,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "${boardDetail1.viewCnt}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        IconButton(
                          onPressed: () {
                            // 하트 api 호출
                            boardDetail1.isLiked = !boardDetail1.isLiked;
                            if (boardDetail1.isLiked) {
                              boardDetail1.likeCnt += 1;
                            } else {
                              boardDetail1.likeCnt -= 1;
                            }

                            BoardService.postLike(
                              boardDetail1.boardId,
                              boardDetail1.isLiked,
                            );
                            setState(() {});
                          },
                          icon: Icon(
                            boardDetail1.isLiked
                                ? Icons.heart_broken
                                : Icons.heart_broken_outlined,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "${boardDetail1.likeCnt}",
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 댓글
            const Divider(
              thickness: 5,
              height: 1,
              color: Color(0xFFEBEBE9),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  //  채팅 개수
                  Row(
                    children: [
                      Image.asset(
                        "assets/image/icons/comentIcon.png",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        boardDetail1.commentCnt.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // 채팅 목록
                  for (var i = 0; i < boardDetail1.comments.length; i++)
                    Container(
                      decoration: i < boardDetail1.comments.length - 1
                          ? const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFEBEBE9),
                                ),
                              ),
                            )
                          : null,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          // 프사
                          ClipOval(
                            child: Image.network(
                              boardDetail1.comments[i].writer.imgUrl,
                              width: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.width / 6,
                              headers: const {
                                "User-Agent":
                                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                              },
                              fit: BoxFit.fitHeight,
                            ),
                          ),

                          const SizedBox(
                            width: 15,
                          ),

                          // 닉네임, 작성시간, 댓글 내용
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                boardDetail1.comments[i].writer.nickName,
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                BoardService.timeAgo(
                                    boardDetail1.comments[i].createdAt),
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.7)),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                boardDetail1.comments[i].content,
                                style: const TextStyle(fontSize: 17),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
