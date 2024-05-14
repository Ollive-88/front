import 'package:flutter/material.dart';
import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/screens/user/favorite_recipe_screen.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/recipe/prcipe_processe_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_difficulty_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_info_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_ingredient_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_score_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_thumbnail_widget.dart';

// ignore: must_be_immutable
class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen(
      {super.key, required this.recipeId, required this.isFavorit});

  int recipeId;
  bool isFavorit;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<RecipeDetailModel> recipeDetail;

  @override
  void initState() {
    super.initState();
    recipeDetail =
        RecipeService.getRecipeDetail(widget.recipeId).catchError((onError) {
      ErrorService.showToast("잘못된 요청입니다.");
      // ignore: invalid_return_type_for_catch_error
      return null;
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
        backgroundColor: const Color(0xFFFFFFFC),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.isFavorit) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoriteRecipeScreen(),
                ),
                (Route<dynamic> route) => route.isFirst,
              );
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FutureBuilder(
              future: recipeDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    icon: snapshot.data!.isScraped
                        ? const Icon(
                            Icons.bookmark,
                            color: Colors.amber,
                            size: 30,
                          )
                        : const Icon(
                            Icons.bookmark_border,
                            size: 30,
                          ),
                    onPressed: () {
                      snapshot.data!.isScraped = !snapshot.data!.isScraped;

                      setState(() {});

                      RecipeService.postFavorit(snapshot.data!.id);
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
        future: recipeDetail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  // 썸네일,제목,인분 수, 시간, 난이도
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        // 썸네일 이미지
                        RecipeThumbnail(
                          thumbnailUrl: snapshot.data!.thumbnailUrl,
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 제목
                        Text(
                          snapshot.data!.title,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 레시피 정보, 인분수, 시간, 난이도
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // 인분수
                            RecipeInfo(
                              iconUrl: "assets/image/icons/peopleIcon.png",
                              text: snapshot.data!.amount,
                            ),

                            // 시간
                            RecipeInfo(
                              iconUrl: "assets/image/icons/timerIcon.png",
                              text: snapshot.data!.time,
                            ),

                            // 난이도
                            RecipeDifficulty(
                              difficulty: snapshot.data!.difficulty,
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    thickness: 3,
                    height: 1,
                    color: Color(0xFFEEEEEC),
                  ),

                  // 재료
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "재료",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0;
                            i < snapshot.data!.ingredients.length;
                            i++)
                          RecipeIngredient(
                            ingredient: snapshot.data!.ingredients[i],
                            isEnd: i == snapshot.data!.ingredients.length - 1,
                          ),
                      ],
                    ),
                  ),

                  const Divider(
                    thickness: 3,
                    height: 1,
                    color: Color(0xFFEEEEEC),
                  ),

                  // 순서, 별점 정보
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "조리순서",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0;
                            i < snapshot.data!.processes.length;
                            i++)
                          Column(
                            children: [
                              RecipeProcesses(
                                processeModel: snapshot.data!.processes[i],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),

                        const SizedBox(
                          height: 20,
                        ),

                        // 별점
                        RecipeScore(
                          recipeId: snapshot.data!.id,
                          score: snapshot.data!.score,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircleAvatar(
                backgroundColor: Color(0xFFFFFFFC),
                backgroundImage: AssetImage("./assets/image/loding/Loding.gif"),
                radius: 60,
              ),
            );
          }
        },
      ),
    );
  }
}
