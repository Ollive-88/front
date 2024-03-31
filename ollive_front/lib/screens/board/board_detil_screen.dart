import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/screens/board/board_write_screen.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

// ignore: must_be_immutable
class BoardDetailScreen extends StatefulWidget {
  const BoardDetailScreen({super.key, required this.boardId});

  final int boardId;

  @override
  State<BoardDetailScreen> createState() => _BoardDetailScreenState();
}

class _BoardDetailScreenState extends State<BoardDetailScreen> {
  late Future<BoardDetailModel> boardDetail;

  @override
  void initState() {
    super.initState();
    boardDetail = BoardService.getBoardDetail(widget.boardId).catchError((e) {
      ErrorService.showToast("잘못된 요청입니다.");
      Navigator.pop(context);
    });
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
        title: FutureBuilder(
          future: boardDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isMine) {
                return Row(
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
                                          builder: (context) =>
                                              BoardWriteScreen(
                                            boardDetail: snapshot.data!,
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
                                    onTap: () async {
                                      await BoardService.deleteBoard(
                                              snapshot.data!.boardId)
                                          .then((value) =>
                                              Navigator.pushNamedAndRemoveUntil(
                                                  context,
                                                  '/home',
                                                  (route) => false))
                                          .catchError((e) {
                                        ErrorService.showToast("잘못된 요청입니다.");
                                        return null;
                                      });
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
                );
              } else {
                return const SizedBox();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      body: FutureBuilder(
        future: boardDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFFFD5D5), // 테두리 색상 설정
                                    width: 2, // 테두리 두께 설정
                                  ),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    snapshot.data!.writer.imgUrl,
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    height:
                                        MediaQuery.of(context).size.width / 8,
                                    headers: const {
                                      "User-Agent":
                                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                    },
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!.writer.nickname,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      BoardService.timeAgo(
                                          snapshot.data!.createdAt),
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
                            snapshot.data!.title,
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 이미지
                        snapshot.data!.images.isNotEmpty
                            ? Container(
                                decoration: const BoxDecoration(),
                                child: CarouselSlider(
                                  options: CarouselOptions(
                                    enableInfiniteScroll: false,
                                  ),
                                  items: snapshot.data!.images
                                      .map(
                                        (img) => Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10), // 여기에 마진 추가

                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1,
                                              img.address,
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
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 20,
                        ),
                        // 본문
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          child: Text(
                            snapshot.data!.content,
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
                                for (var tag in snapshot.data!.tags)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, bottom: 10),
                                    child: Tag(
                                      tagModel: TagModel(tag.tagName),
                                      isSearch: false,
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 뷰카운트, 라이크카운트
                        Row(
                          children: [
                            const Icon(
                              Icons.remove_red_eye,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "${snapshot.data!.viewCount}",
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
                                snapshot.data!.isLiked =
                                    !snapshot.data!.isLiked;
                                if (snapshot.data!.isLiked) {
                                  snapshot.data!.likeCount += 1;
                                } else {
                                  snapshot.data!.likeCount -= 1;
                                }

                                BoardService.postLike(
                                  snapshot.data!.boardId,
                                  snapshot.data!.isLiked,
                                );
                                setState(() {});
                              },
                              icon: Icon(
                                snapshot.data!.isLiked
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline,
                                size: 30,
                              ),
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "${snapshot.data!.likeCount}",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            )
                          ],
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
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
                              snapshot.data!.comments.length.toString(),
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 채팅 목록
                        for (var i = 0; i < snapshot.data!.comments.length; i++)
                          Container(
                            decoration: i < snapshot.data!.comments.length - 1
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
                                    snapshot.data!.comments[i].writer.imgUrl,
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    height:
                                        MediaQuery.of(context).size.width / 6,
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
                                      snapshot
                                          .data!.comments[i].writer.nickname,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      BoardService.timeAgo(
                                          snapshot.data!.comments[i].createdAt),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.7)),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      snapshot.data!.comments[i].content,
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
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: // 댓글 입력 창
          Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
        ),
        child: Stack(
          children: [
            TextField(
              // focusNode: context.read<ChatController>().focusNode,
              // onChanged:
              //     context.read<ChatController>().onFieldChanged,
              // controller: context
              //     .read<ChatController>()
              //     .textEditingController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  right: 42,
                  left: 16,
                  top: 18,
                ),
                hintText: '댓글을 입력하세요.',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            // custom suffix btn
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
