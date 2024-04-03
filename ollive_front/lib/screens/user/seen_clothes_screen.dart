import 'package:flutter/material.dart';
import 'package:ollive_front/models/cloth/cloth_model.dart';
import 'package:ollive_front/service/cloth/cloth_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/cloth/cloth_widget.dart';

class SeenClothesScreen extends StatefulWidget {
  const SeenClothesScreen({super.key});

  @override
  State<SeenClothesScreen> createState() => _SeenClothesScreenState();
}

class _SeenClothesScreenState extends State<SeenClothesScreen> {
  late Future<List<ClothModel>> clothes;

  // 한번에 받을 레시피 개수
  final int size = 10;
  // 마지막 레시피 인덱스
  int lastIndex = 0;

  // 라스트 인덱스 업데이트 메서드
  void updateLastIndex(int index) {
    lastIndex = index;
  }

  // 무한 스크롤 감지 컨트롤러
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      List<ClothModel> currentCloth = await clothes;

      await ClothService.getSeenClothesList(
        lastIndex,
        size,
      ).then((value) {
        if (value.isEmpty) {
          ErrorService.showToast("마지막 페이지 입니다.");
        } else {
          setState(() {
            // 레시피 리스트 초기화
            currentCloth.addAll(value);

            updateLastIndex(value[value.length - 1].id);

            clothes = Future.value(currentCloth);
          });
        }
      }).catchError((onError) {
        ErrorService.showToast("잘못된 요청입니다.");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    clothes = ClothService.getSeenClothesList(
      lastIndex,
      size,
    );
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('최근 본 의류'),
        centerTitle: true,
      ),
      // 이거 Future Builder로 만들어야함!
      body: FutureBuilder(
          future: clothes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data!.isNotEmpty)
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Wrap(
                          children: [
                            for (ClothModel cloth in snapshot.data!)
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 15, bottom: 15),
                                child: ClothWidget(clothModel: cloth),
                              ),
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('의류를 본 이력이 없어요.'),
                        ],
                      ),
                    );
            } else {
              return const Center(
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFFFFFC),
                  backgroundImage:
                      AssetImage("./assets/image/loding/Loding.gif"),
                  radius: 60,
                ),
              );
            }
          }),
    );
  }
}
