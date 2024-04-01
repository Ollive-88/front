import 'package:flutter/material.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/screens/board/board_screen.dart';
import 'package:ollive_front/widgets/board/board_tag_widget.dart';

class BoardSearchScreen extends StatefulWidget {
  const BoardSearchScreen({super.key});
  @override
  State<BoardSearchScreen> createState() => _BoardSearchScreenState();
}

class _BoardSearchScreenState extends State<BoardSearchScreen> {
  final TextEditingController _inputController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  // 태그 리스트
  List<TagModel> tagNames = [];

  // 태그 입력 처리 메서드
  void _handleInput(String input) {
    if (input.endsWith(' ')) {
      print("work");
      // 해시태그를 찾기 위한 정규 표현식
      final RegExp regExp = RegExp(r"#([\w가-힣-]+)");
      // 모든 해시태그 찾기
      final Iterable<RegExpMatch> matches = regExp.allMatches(input);
      if (matches.isNotEmpty) {
        // 해시태그 제거 후 남은 문자열을 저장할 변수
        String remainingText = input;

        setState(() {
          for (final match in matches) {
            // 해시태그에서 '#' 제거 후 tagNames에 추가
            String tagName = match.group(0)!; // '#'을 포함한 전체 해시태그
            tagNames.add(TagModel(tagName.substring(1))); // '#' 제거 후 추가

            // 해시태그를 포함한 문자열에서 해시태그 제거
            remainingText = remainingText.replaceAll(tagName, "");
          }
          // 해시태그를 제외한 나머지 문자열로 텍스트 필드 업데이트
          _inputController.text = remainingText;
        });
      }
    }
  }

  // 태그 지우는 메서드
  void deleteTags(int index) {
    tagNames.removeAt(index);
    setState(() {});
  }

  // 검색 메서드
  void onclickSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BoardScreen(
          tagNames: tagNames,
          keyword: _inputController.text,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 9,
          centerTitle: true,
          surfaceTintColor: const Color(0xFFFFFFFC),
          shadowColor: Colors.black,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFEBEBE9)),
                  // ignore: deprecated_member_use
                  child: TextField(
                    controller: _inputController,
                    onChanged: _handleInput,
                    onEditingComplete: onclickSearch,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                    ),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
          shape: const Border(
            bottom: BorderSide(
              width: 7,
              color: Color(0xFFEBEBE9),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Wrap(
                spacing: 8.0, // 가로 방향의 태그 사이 간격
                runSpacing: 4.0,
                children: [
                  for (int i = 0; i < tagNames.length; i++)
                    Tag(
                      tagModel: tagNames[i],
                      isSearch: true,
                      deleteTag: () => deleteTags(i),
                    )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
