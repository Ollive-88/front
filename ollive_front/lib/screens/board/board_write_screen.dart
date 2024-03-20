import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

class BoardWriteScreen extends StatefulWidget {
  const BoardWriteScreen({super.key});

  @override
  State<BoardWriteScreen> createState() => _BoardWriteScreenState();
}

class _BoardWriteScreenState extends State<BoardWriteScreen> {
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // 태그 리스트
  List<String> tagNames = [];

  // 태그 입력 처리 메서드
  void subStringTags() {
    String text = _inputController.text;
    RegExp regExp = RegExp(r"[\uAC00-\uD7A3a-zA-Z0-9_]+");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    for (var match in matches) {
      text = text.replaceFirst(match.group(0)!.substring(1), '');
      tagNames.add(match.group(0)!);
    }

    setState(() {
      _inputController.text = text.trim(); // trim()을 사용해 앞뒤 공백 제거
    });
  }

  // 태그 지우는 메서드
  void deleteTags(int index) {
    tagNames.removeAt(index);
    setState(() {});
  }

  // 키보드 위치 변수
  double keyboardHeight = 0.0;

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
                onTap: () {},
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
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      TextFormField(
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
                      RawKeyboardListener(
                        focusNode: _focusNode,
                        onKey: (event) {
                          if (event.physicalKey.debugName == "Space") {
                            subStringTags();
                          }
                        },
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 4.5,
                          child: SingleChildScrollView(
                            child: TextFormField(
                              controller: _inputController,
                              maxLines: 50,
                              decoration: InputDecoration(
                                prefix: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 30),
                                  child: Column(
                                    children: [
                                      Wrap(
                                        spacing: 8.0, // 가로 방향의 태그 사이 간격
                                        runSpacing: 4.0,
                                        children: [
                                          for (int i = 0;
                                              i < tagNames.length;
                                              i++)
                                            Tag(
                                              tagName: tagNames[i],
                                              isSearch: true,
                                              deleteTag: () => deleteTags(i),
                                            )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                hintText: "태그를 입력하세요",
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                // 포커스를 받았을 때의 테두리 스타일
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
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
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.image,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
