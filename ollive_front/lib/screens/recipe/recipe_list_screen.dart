import 'package:flutter/material.dart';
import 'package:ollive_front/models/recipe/recipe_model.dart';
import 'package:ollive_front/screens/recipe/recipe_detail_screen.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/recipe/recipe_scroller_widget.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({
    super.key,
    required this.likeTagNames,
    required this.hateTagNames,
    required this.recommendrecipes,
  });

  final List<String> likeTagNames;
  final List<String>? hateTagNames;
  final List<RecipeModel> recommendrecipes;

  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  // 카테고리 대분류 리스트
  final List<String> caseList = [
    "추천별",
    "종류별",
    "상황별",
    "방법별",
  ];

  // 카테고리 소분류 리스트
  late List<List<String>> categotyList = [
    categotyList1,
    categotyList2,
    categotyList3,
    categotyList4
  ];

  // 추천별 리스트
  final List<String> categotyList1 = [];

  // 종류별 리스트
  final List<String> categotyList2 = [
    "전체",
    "밑반찬",
    "메인반찬",
    "국/탕",
    "찌개",
    "디저트",
    "면/만두",
    "밥/죽/떡",
    "퓨전",
    "김치/젓갈/장류",
    "양념/소스/잼",
    "양식",
    "샐러드",
    "스프",
    "빵",
    "과자",
    "차/음료/술",
    "기타",
  ];

  // 상황별 리스트
  final List<String> categotyList3 = [
    "전체",
    "일상",
    "초스피드",
    "손님접대",
    "술안주",
    "다이어트",
    "도시락",
    "영양식",
    "간식",
    "야식",
    "푸드스타일링",
    "해장",
    "명절",
    "이유식",
    "기타",
  ];

  // 방법별 리스트
  final List<String> categotyList4 = [
    "전체",
    "볶음",
    '끓이기',
    '부침',
    "조림",
    "무침",
    "비빔",
    "찜",
    "절임",
    "튀김",
    "삶기",
    "굽기",
    "데치기",
    '회',
    "기타"
  ];

  // 대분류 선택한 항목
  int seletedCase = 0;

  // 소분류 선택 리스트
  late List<int> seletedCategoty = [
    seletedCategoty1,
    seletedCategoty2,
    seletedCategoty3,
    seletedCategoty4,
  ];
  // 소분류 별 선택한 항목
  int seletedCategoty1 = 0;
  int seletedCategoty2 = 0;
  int seletedCategoty3 = 0;
  int seletedCategoty4 = 0;

  // 유저가 선택한 대분류, 소분류
  late String recipeCase;
  late String recipeCategory = "";
  // 한번에 받을 레시피 개수
  final int size = 10;
  // 마지막 레시피 인덱스
  int lastIndex = 0;
  // 라스트 인덱스 업데이트 메서드
  void updateLastIndex(int index) {
    lastIndex = index;
  }

  late List<RecipeModel> recipes;

  // 대분류 선택 메서드
  void onClickCase(int i) async {
    if (i < 1) {
      seletedCase = i;
      recipeCase = caseList[i];

      for (var i = 0; i < seletedCategoty.length; i++) {
        seletedCategoty[i] = 0;
      }

      recipes = widget.recommendrecipes;

      updateLastIndex(0);
    } else {
      seletedCase = i;
      recipeCase = caseList[i];

      for (var i = 0; i < seletedCategoty.length; i++) {
        seletedCategoty[i] = 0;
      }

      // 레시피 리스트 초기화
      await RecipeService.getRecipeList(
        widget.likeTagNames,
        widget.hateTagNames,
        recipeCase,
        "",
        0,
        size,
      ).then((value) {
        recipes = value;
        if (recipes.isNotEmpty) {
          updateLastIndex(recipes[recipes.length - 1].recipeId);
        }
      }).catchError((onError) {
        ErrorService.showToast("잘못된 요청입니다.");
      });
    }
    setState(() {});
  }

  // 소분류 선택 메서드
  void onClickcategoty(int i) async {
    String temp = recipeCategory;
    recipeCategory = categotyList[seletedCase][i];

    await RecipeService.getRecipeList(
      widget.likeTagNames,
      widget.hateTagNames,
      recipeCase,
      recipeCategory,
      0,
      size,
    ).then((value) {
      for (var i = 0; i < seletedCategoty.length; i++) {
        seletedCategoty[i] = 0;
      }

      seletedCategoty[seletedCase] = i;

      // 레시피 리스트 초기화
      recipes = value;

      if (recipes.isNotEmpty) {
        updateLastIndex(recipes[recipes.length - 1].recipeId);
      }
    }).catchError((onError) {
      recipeCategory = temp;
      ErrorService.showToast("잘못된 요청입니다.");
    });
    setState(() {});
  }

  // 무한 스크롤 감지 컨트롤러
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() async {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        seletedCase > 0) {
      await RecipeService.getRecipeList(
        widget.likeTagNames,
        widget.hateTagNames,
        recipeCase,
        recipeCategory,
        lastIndex,
        size,
      ).then((value) {
        if (value.isEmpty) {
          ErrorService.showToast("마지막 페이지 입니다.");
        } else {
          // 레시피 리스트 초기화
          recipes.addAll(value);
          updateLastIndex(recipes[recipes.length - 1].recipeId);

          setState(() {});
        }
      }).catchError((onError) {
        ErrorService.showToast("잘못된 요청입니다.");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    recipes = widget.recommendrecipes;
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
      backgroundColor: const Color(0xFFFFFFFC),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFC),
        foregroundColor: Colors.black,
      ),
      floatingActionButton: RecipeScrollerButton(
        controller: _scrollController,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 대분류
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var i = 0; i < caseList.length; i++)
                    GestureDetector(
                      onTap: () {
                        onClickCase(i);
                      },
                      child: Text(
                        caseList[i],
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: seletedCase == i
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ),
                ],
              ),
            ),

            // 소분류
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: const BoxDecoration(color: Color(0xFFEBEBE9)),
                child: Row(
                  children: [
                    for (var i = 0; i < categotyList[seletedCase].length; i++)
                      GestureDetector(
                        onTap: () {
                          onClickcategoty(i);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            categotyList[seletedCase][i],
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: seletedCategoty[seletedCase] == i
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // 레시피 리스트
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Wrap(
                spacing: 20.0,
                runSpacing: 5.0,
                children: [
                  for (int i = 0; i < recipes.length; i++)
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width / 2.3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 5,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  offset: const Offset(4, 3), // 그림자 위치
                                ),
                              ],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailScreen(
                                      recipeId: recipes[i].recipeId,
                                      isFavorit: false,
                                    ),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  height:
                                      MediaQuery.of(context).size.width / 2.3,
                                  recipes[i].thumbnail,
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
                            recipes[i].title,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            maxLines: 2, // 최대 줄 수를 2로 설정
                            overflow:
                                TextOverflow.ellipsis, // 내용이 넘칠 때 '...'으로 표시
                          ),
                        ],
                      ),
                    )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
