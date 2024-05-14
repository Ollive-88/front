import 'package:flutter/material.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/screens/recipe/recipe_detail_screen.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';
import 'package:ollive_front/util/error/error_service.dart';

class FavoriteRecipeScreen extends StatefulWidget {
  const FavoriteRecipeScreen({super.key});

  @override
  State<FavoriteRecipeScreen> createState() => _FavoriteRecipeScreenState();
}

class _FavoriteRecipeScreenState extends State<FavoriteRecipeScreen> {
  late Future<List<RecipeModel>> recipes;

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
      List<RecipeModel> currentRecipe = await recipes;

      await RecipeService.getFavoirtRecipeList(
        lastIndex,
        size,
      ).then((value) {
        if (value.isEmpty) {
          ErrorService.showToast("마지막 페이지 입니다.");
        } else {
          setState(() {
            // 레시피 리스트 초기화
            currentRecipe.addAll(value);

            updateLastIndex(value[value.length - 1].recipeId);

            recipes = Future.value(currentRecipe);
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
    recipes = RecipeService.getFavoirtRecipeList(
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
        title: const Text(
          '즐겨찾는 레시피',
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: recipes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return (snapshot.data!.isNotEmpty)
                  ? SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          // 레시피 리스트
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Wrap(
                              spacing: 20.0,
                              runSpacing: 5.0,
                              children: [
                                for (int i = 0; i < snapshot.data!.length; i++)
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2.3),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: const Offset(
                                                    4, 3), // 그림자 위치
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RecipeDetailScreen(
                                                    recipeId: snapshot
                                                        .data![i].recipeId,
                                                    isFavorit: true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Image.network(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                snapshot.data![i].thumbnail,
                                                headers: const {
                                                  "User-Agent":
                                                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                                                },
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          snapshot.data![i].title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          maxLines: 2, // 최대 줄 수를 2로 설정
                                          overflow: TextOverflow
                                              .ellipsis, // 내용이 넘칠 때 '...'으로 표시
                                        ),
                                      ],
                                    ),
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('등록한 레시피가 없어요.'),
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
