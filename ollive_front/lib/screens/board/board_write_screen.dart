import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ollive_front/models/board/board_post_model.dart';
import 'package:ollive_front/service/board/board_service.dart';
import 'package:ollive_front/widgets/board/board_image_widget.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

class BoardWriteScreen extends StatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  // 키보드 위치 변수
  double keyboardHeight = 0.0;
  // 태그 입력 컨트롤
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _inputController = TextEditingController();
  // 태그 스크롤 컨트롤
  final ScrollController _scrollController = ScrollController();
  // 태그 포커스 노드
  final FocusNode _focusNode = FocusNode();
  // 태그 리스트
  List<String> tagNames = [];

  // 이미지 피커
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _pickedImgs = [];

  // 태그 입력 처리 메서드
  void subStringTags() {
    String text = _inputController.text;
    RegExp regExp = RegExp(r"[\uAC00-\uD7A3a-zA-Z0-9_]+");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    for (var match in matches) {
      text = text.replaceFirst(match.group(0)!, '');
      tagNames.add(match.group(0)!);
    }
    _inputController.text = text.trim(); // trim()을 사용해 앞뒤 공백 제거
    _scrollToBottom();

    setState(() {});
  }

  // 태그 지우는 메서드
  void deleteTags(int index) {
    tagNames.removeAt(index);
    setState(() {});
  }

  // 태그 스크롤 뷰 자동 포커싱
  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent +
          100, // 100은 추가될 항목의 대략적인 높이입니다.
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  // 이미지 선택 메서드
  Future<void> _pickImg() async {
    final List<XFile> images = await _picker.pickMultiImage();

    setState(() {
      for (var image in images) {
        if (_pickedImgs.length < 5) {
          _pickedImgs.add(image);
        }
      }
    });
  }

  // 이미지 지우는 메서드
  void deleteImage(int index) {
    _pickedImgs.removeAt(index);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    // 포커스 초기화
    _focusNode.requestFocus();

    // 키보드 상태 변화 감지
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewInsets = MediaQuery.of(context).viewInsets.bottom;
      if (viewInsets != keyboardHeight) {
        setState(() {
          keyboardHeight = viewInsets;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          centerTitle: true,
          surfaceTintColor: const Color(0xFFFFFFFC),
          shadowColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 방향 중앙 정렬
            children: [
              const Expanded(
                child: Text(
                  "글쓰기",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  BoardPostModel postModel = BoardPostModel(
                      title: _titleController.text,
                      content: _contentController.text,
                      tags: tagNames,
                      imgs: _pickedImgs);
                  Future<int> result = BoardService.postBoard(postModel);

                  if (result == 200) {
                    Navigator.pop(context);
                  } else {
                    // 오류 모달 생성
                  }
                },
                child: const Text(
                  "완료",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          shape: const Border(
            bottom: BorderSide(
              width: 2,
              color: Color(0xFFEBEBE9),
            ),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom / 4,
                    right: 15,
                    left: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          hintText: "제목을 입력하세요",
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFEBEBE9),
                            ),
                          ),
                          // 포커스를 받았을 때의 테두리 스타일
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xFFEBEBE9),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color(0xFFEBEBE9), // 여기서 원하는 색상을 선택하세요
                              width: 3, // 밑줄의 두께를 지정하세요
                            ),
                          ),
                        ),
                        height: MediaQuery.of(context).size.height / 2,
                        child: TextFormField(
                          controller: _contentController,
                          maxLines: 100,
                          decoration: const InputDecoration(
                            hintText: "내용을 입력하세요",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      RawKeyboardListener(
                        focusNode: _focusNode,
                        onKey: (event) {
                          if (event.physicalKey.debugName == "Space") {
                            subStringTags();
                          }
                        },
                        child: TextFormField(
                          controller: _inputController,
                          decoration: const InputDecoration(
                            hintText: "태그를 입력하세요",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 5),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (int i = 0; i < tagNames.length; i++)
                                Tag(
                                  tagName: tagNames[i],
                                  isSearch: true,
                                  deleteTag: () => deleteTags(i),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: keyboardHeight,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFC),
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFFEBEBE9),
                      width: 3,
                    ),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double containerHeight = constraints.maxHeight * 0.5;
                    print(containerHeight);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.image),
                          color: Colors.black,
                          onPressed: () {
                            _pickImg();
                          },
                        ),
                        SingleChildScrollView(
                          child: Row(
                            children: [
                              for (var i = 0; i < _pickedImgs.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 4),
                                  child: BoardImage(
                                    image: _pickedImgs[i],
                                    heght:
                                        MediaQuery.of(context).size.height / 10,
                                    deleteImage: () => deleteImage(i),
                                  ),
                                )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
