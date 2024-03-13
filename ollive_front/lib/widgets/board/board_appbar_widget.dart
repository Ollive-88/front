import 'package:flutter/material.dart';

class BoardAppBar extends StatelessWidget {
  const BoardAppBar({
    super.key,
    this.keyword,
  });

  final String? keyword;

  @override
  Widget build(BuildContext context) {
    // 검색어 유무에 따라 다른 appbar 리턴
    return keyword == null
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 방향 중앙 정렬
            children: [
              const Text(
                "사람사는 이야기",
                style: TextStyle(
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/board/search');
                },
                icon: const Icon(Icons.search),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center, // 수직 방향 중앙 정렬
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFEBEBE9)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: Text(
                      keyword!,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/board/search');
                },
                icon: const Icon(Icons.search),
              )
            ],
          );
  }
}