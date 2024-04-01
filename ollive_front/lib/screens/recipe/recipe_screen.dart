import 'package:flutter/material.dart';
import 'package:ollive_front/screens/recipe/recipe_list_screen.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/recipe/recipe_tag_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_textfield_widget.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  // 태그 리스트
  List<String> havingIngredients = [];
  List<String> dislikeIngredients = [];
  // 냉장고/제외 재료 리스트
  List<String> refrigerators = [];
  List<String> ingredients = [];

  List<bool> isRefrigeratorsSelected = [];
  List<bool> isIngredientsSelected = [];

  void selstedItem(List<bool> isSelected, int i) {
    isSelected[i] = !isSelected[i];
  }

  void addRefrigerators(List<bool> isSelected, bool isLiked) {
    if (isLiked) {
      for (var i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          havingIngredients.add(refrigerators[i]);
          isSelected[i] = false;
        }
      }
    } else {
      for (var i = 0; i < isSelected.length; i++) {
        if (isSelected[i]) {
          dislikeIngredients.add(ingredients[i]);
          isSelected[i] = false;
        }
      }
    }

    setState(() {});
  }

  void initIgredientsList() async {
    await UserService.getFridgeIngredients().then((value) {
      for (var i = 0; i < value.length; i++) {
        refrigerators.add(value[i].name);
      }
    }).catchError((e) {
      ErrorService.showToast("잘못된 요청입니다.");
    });

    await UserService.getDislikeIngredients().then((value) {
      for (var i = 0; i < value.length; i++) {
        ingredients.add(value[i].name);
      }
    }).catchError((e) {
      ErrorService.showToast("잘못된 요청입니다.");
    });

    isRefrigeratorsSelected =
        List.generate(refrigerators.length, (index) => false);
    isIngredientsSelected = List.generate(ingredients.length, (index) => false);
  }

  @override
  void initState() {
    super.initState();
    initIgredientsList();
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
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          backgroundColor: const Color(0xFFFFFFFC),
          title: const Center(
            child: Text(
              "레시피를 부탁해",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 소개글
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '냉장고 속의 남는 재료',
                            style: TextStyle(
                              color: Color(0xFF30AF98),
                            ), // 변경할 색상
                          ),
                          TextSpan(text: '들을 알려주시면 '),
                          TextSpan(
                            text: '최적의 레시피',
                            style: TextStyle(
                              color: Color(0xFF30AF98),
                            ), // 변경할 색상
                          ),
                          TextSpan(text: '를 추천해 드릴게요'),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // 냉장고 재료

                    const Text(
                      "  냉장고 재료",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RecipeTextField(
                      ingredients: havingIngredients,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // 싫어하는 재료
                    const Text(
                      "  제외 재료",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RecipeTextField(
                      ingredients: dislikeIngredients,
                    ),

                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              const Divider(
                thickness: 3,
                height: 1,
                color: Color(0xFFEBEBE9),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    // 내가가진 식재료
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFC),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // 상단바
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Text(
                                              "전체선택",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "냉장고 목록",
                                            style: TextStyle(fontSize: 22),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {
                                              addRefrigerators(
                                                isRefrigeratorsSelected,
                                                true,
                                              );
                                              Navigator.pop(context);
                                            },
                                            icon: const Text(
                                              "추가",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    thickness: 2,
                                    height: 1,
                                    color: Color(0xFFEBEBE9),
                                  ),

                                  // 재료 목록
                                  Wrap(
                                    children: [
                                      for (var i = 0;
                                          i < refrigerators.length;
                                          i++)
                                        RecipeTag(
                                          tagName: refrigerators[i],
                                          isSelected:
                                              isRefrigeratorsSelected[i],
                                          select: () => selstedItem(
                                              isRefrigeratorsSelected, i),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/image/icons/refrigeratorIcon.png",
                          ),
                          const Text(
                            "내가 가진 식재료",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const Divider(
                      thickness: 3,
                      height: 1,
                      color: Color(0xFFEBEBE9),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // 싫어하는 재료 목록
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Color(0xFFFFFFFC),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // 상단바
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Text(
                                              "전체선택",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 2,
                                          child: Text(
                                            "냉장고 목록",
                                            style: TextStyle(fontSize: 22),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            onPressed: () {
                                              addRefrigerators(
                                                isIngredientsSelected,
                                                false,
                                              );
                                              Navigator.pop(context);
                                            },
                                            icon: const Text(
                                              "추가",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  const Divider(
                                    thickness: 2,
                                    height: 1,
                                    color: Color(0xFFEBEBE9),
                                  ),

                                  // 재료 목록
                                  Wrap(
                                    children: [
                                      for (var i = 0;
                                          i < ingredients.length;
                                          i++)
                                        RecipeTag(
                                          tagName: ingredients[i],
                                          isSelected: isIngredientsSelected[i],
                                          select: () => selstedItem(
                                            isIngredientsSelected,
                                            i,
                                          ),
                                        )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/image/icons/ingredientsIcon.png",
                          ),
                          const Text(
                            "싫어하는 재료 목록",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          const Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: // 검색 버튼
            GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();

            if (havingIngredients.isEmpty) {
              ErrorService.showToast("포함시킬 재료를 선택해주세요");
            } else {
              await RecipeService.getRecommendRecipeList(
                havingIngredients,
                dislikeIngredients,
              ).then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeListScreen(
                      likeTagNames: havingIngredients,
                      hateTagNames: dislikeIngredients,
                      recommendrecipes: value,
                    ),
                  ),
                );
              }).catchError((onError) {
                ErrorService.showToast("잘못된 요청입니다.");
              });
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 1.1,
            height: MediaQuery.of(context).size.height / 11,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF30AF98),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "검색",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
