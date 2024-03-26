import 'package:flutter/material.dart';
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
  List<String> tagNames = [];

  // 태그 입력 처리 메서드
  void subStringTags() {
    String text = _inputController.text;
    RegExp regExp = RegExp(r"#[\uAC00-\uD7A3a-zA-Z0-9_]+");
    Iterable<RegExpMatch> matches = regExp.allMatches(text);

    for (var match in matches) {
      text = text.replaceFirst(match.group(0)!, '');
      tagNames.add(match.group(0)!.substring(1));
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
    return Scaffold(
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
                child: RawKeyboardListener(
                  focusNode: _focusNode,
                  onKey: (event) {
                    if (event.physicalKey.debugName == "Space") {
                      subStringTags();
                    }
                  },
                  child: TextField(
                    controller: _inputController,
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
                    tagName: tagNames[i],
                    isSearch: true,
                    deleteTag: () => deleteTags(i),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
