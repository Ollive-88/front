import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ollive_front/models/user/user_simple_model.dart';
import 'package:ollive_front/screens/user/favorite_recipe_screen.dart';
import 'package:ollive_front/screens/user/fridge_inventory_screen.dart';
import 'package:ollive_front/screens/user/hate_inventory_screen.dart';
import 'package:ollive_front/screens/user/seen_clothes_screen.dart';
import 'package:ollive_front/screens/user/setting/my_article_screen.dart';
import 'package:ollive_front/screens/user/setting/setting_screen.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  static String baseAddress = 'assets/image/icons/';

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  final List<List<dynamic>> settings = [
    ['refrigeratorIcon.png', '냉장고 관리'],
    ['ingredientsIcon.png', '싫어하는 재료 목록'],
    ['recipeIcon.png', '즐겨찾는 레시피'],
    ['clothesIcon.png', '최근 본 의류'],
    ['myBoardIcon.png', '내 게시글'],
    ['settingIcon.png', '설정'],
  ];

  final List<Widget> pages = [
    const FridgeInventoryScreen(),
    const HateInventoryScreen(),
    const FavoriteRecipeScreen(),
    const SeenClothesScreen(),
    const MyArticleScreen(),
    const SettingScreen(),
  ];

  late Future<UserSimpleModel> userInfo;

  final StatusController _userInfoController = Get.put(StatusController());

  @override
  void initState() {
    super.initState();
    userInfo = UserService.getUserInfo().then((value) {
      _userInfoController.setNickname(value.nickname);
      if (value.imgUrl != null) {
        _userInfoController.setImgUrl(value.imgUrl!);
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      body: FutureBuilder(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Obx(
                              () => (_userInfoController.imgUrl != '')
                                  ? MakeCircleImage(
                                      imageUrl: _userInfoController.imgUrl,
                                      width: 200,
                                      height: 200,
                                    )
                                  : ClipOval(
                                      child: Image.asset(
                                        'assets/image/icons/basic_profile_img.png',
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(
                              () => Text(
                                _userInfoController.nickname,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w700),
                              ),
                            ),
                            // Text(
                            //   snapshot.data!.nickname,
                            //   style: const TextStyle(
                            //       fontSize: 20, fontWeight: FontWeight.w700),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 5,
                        color: Color(0xFFEBEBE9),
                      ),
                      for (var i = 0; i < 6; i++)
                        Column(
                          children: [
                            ListTile(
                              leading: Image.asset(
                                '${MyPageScreen.baseAddress}${settings[i][0]}',
                                width: 28,
                                height: 28,
                              ),
                              title: Text(settings[i][1]),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => pages[i]));
                              },
                            ),
                            // 마지막에는 생성 X
                            i != 4
                                ? const Divider(
                                    height: 2,
                                    color: Color(0xFFEEEEEC),
                                  )
                                : const SizedBox()
                          ],
                        )
                    ],
                  ),
                ),
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

class MakeCircleImage extends StatelessWidget {
  final String imageUrl;
  final double width, height;

  const MakeCircleImage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
