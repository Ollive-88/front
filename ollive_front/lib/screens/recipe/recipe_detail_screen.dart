import 'package:flutter/material.dart';
import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/service/recipe/recipe_service.dart';
import 'package:ollive_front/widgets/recipe/prcipe_processe_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_difficulty_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_info_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_ingredient_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_score_widget.dart';
import 'package:ollive_front/widgets/recipe/recipe_thumbnail_widget.dart';

// ignore: must_be_immutable
class RecipeDetailScreen extends StatefulWidget {
  RecipeDetailScreen({super.key, required this.recipeId});

  String recipeId;

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<RecipeDetailModel> recipeDetail =
      RecipeService.getRecipeDetail(widget.recipeId);

  // Todo : 나중에 지우기
  RecipeDetailModel recipeDetail1 = RecipeDetailModel.fromJson({
    "id": 1,
    "title": "새송이버섯소고기볶음 끼니마다 가족들이 이것만 찾아요~ ‼️",
    "thumbnail_url":
        "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/5461e570361e2a662f7ea5abb73e96c01.jpg",
    "amount": "3인분",
    "time": "15분 이내",
    "difficulty": "초급",
    "score": 0.0,
    "isFavorite": true,
    "categories": [
      {
        "name": "밑반찬",
        "category_id": 1,
        "recipe_case_id": 4,
        "recipe_case_name": "종류별"
      },
      {
        "name": "일상",
        "category_id": 18,
        "recipe_case_id": 2,
        "recipe_case_name": "상황별"
      },
      {
        "name": "소고기",
        "category_id": 32,
        "recipe_case_id": 3,
        "recipe_case_name": "재료별"
      },
      {
        "name": "볶음",
        "category_id": 48,
        "recipe_case_id": 1,
        "recipe_case_name": "방법별"
      }
    ],
    "ingredients": [
      {"name": "새송이버섯", "amount": "4개"},
      {"name": "국거리소고기", "amount": "150g"},
      {"name": "양파", "amount": "1/2개"},
      {"name": "대파", "amount": "1/2대"},
      {"name": "청양고추", "amount": "2개"},
      {"name": "진간장", "amount": "1큰술"},
      {"name": "참기름", "amount": "1큰술"},
      {"name": "참치액젓", "amount": "1큰술"},
      {"name": "설탕", "amount": "1/2큰술"},
      {"name": "물엿", "amount": "1큰술"},
      {"name": "후추", "amount": "톡톡"},
      {"name": "다진마늘", "amount": "1큰술"}
    ],
    "processes": [
      {
        "content": "소고기 150g 진간장 1큰술, 참기름 1큰술 넣어 조물조물 밑간합니다.",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/ff9e637e3cd96de316b2f64805ebdbae1.jpg",
        "cookOrder": 1
      },
      {
        "content":
            "새송이버섯4개 일정한 두께로 썰은 후 끓는물에 20초간 데쳐요 데친 버섯은 찬물에 헹궈 물기를 꼬옥 짜주세요",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/c573f7efec28d866b198dcc4af6e3e251.jpg",
        "cookOrder": 2
      },
      {
        "content": "팬에 기름을 살짝 두른 후 소고기 넣어 볶아요 추가로 양파 넣어 볶아주세요",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/c53dea8a737ef7a3c0a5a214821edcff1.jpg",
        "cookOrder": 3
      },
      {
        "content": "참치액젓 1큰술 넣어 볶다가, 설탕 1/2큰술 넣어 볶아줘요",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/e49ea66405b4ec7ca7b71668abc343e81.jpg",
        "cookOrder": 4
      },
      {
        "content": "새송이버섯을 넣어 볶다가 청양고추2개 어슷썰어 넣어줍니다 물엿 1큰술 넣어 잘 볶아준 뒤",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/ef7dc34645214383aec8864842d24f1c1.jpg",
        "cookOrder": 5
      },
      {
        "content": "어슷썬대파, 다진마늘 1큰술, 후추 톡톡 넣어 볶아주면 완성입니다",
        "imageUrl":
            "https://recipe1.ezmember.co.kr/cache/recipe/2023/10/04/06897107b2b8e718b9114072232ad3051.jpg",
        "cookOrder": 6
      }
    ]
  });

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: recipeDetail1.isFavorite
                  ? const Icon(
                      Icons.bookmark,
                      color: Colors.amber,
                      size: 40,
                    )
                  : const Icon(
                      Icons.bookmark_border,
                      size: 40,
                    ),
              onPressed: () {
                recipeDetail1.isFavorite = !recipeDetail1.isFavorite;

                setState(() {});

                RecipeService.postFavorit(recipeDetail1.recipeId);
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
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
                    thumbnailUrl: recipeDetail1.thumbnailUrl,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // 제목
                  Text(
                    recipeDetail1.title,
                    style: const TextStyle(fontSize: 24),
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
                        text: recipeDetail1.amount,
                      ),

                      // 시간
                      RecipeInfo(
                        iconUrl: "assets/image/icons/timerIcon.png",
                        text: recipeDetail1.time,
                      ),

                      // 난이도
                      RecipeDifficulty(
                        difficulty: recipeDetail1.difficulty,
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
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < recipeDetail1.ingredients.length; i++)
                    RecipeIngredient(
                      ingredient: recipeDetail1.ingredients[i],
                      isEnd: i == recipeDetail1.ingredients.length - 1,
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
                    style: TextStyle(fontSize: 26),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  for (int i = 0; i < recipeDetail1.processes.length; i++)
                    RecipeProcesses(
                      processeModel: recipeDetail1.processes[i],
                    ),

                  const SizedBox(
                    height: 10,
                  ),

                  // 별점
                  RecipeScore(
                    recipeId: recipeDetail1.recipeId,
                    score: recipeDetail1.score,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
