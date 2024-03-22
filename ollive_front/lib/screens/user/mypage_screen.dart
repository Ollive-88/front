import 'package:flutter/material.dart';
import 'package:ollive_front/screens/user/fridge_inventory_screen.dart';

class MyPageScreen extends StatelessWidget {
  MyPageScreen({super.key});

  static String baseAddress = 'assets/image/icons/';
  final List<List<dynamic>> settings = [
    ['alramIcon.png', '알림'],
    ['refrigeratorIcon.png', '냉장고 관리'],
    ['ingredientsIcon.png', '싫어하는 재료 목록'],
    ['recipeIcon.png', '즐겨 찾는 레시피'],
    ['clothesIcon.png', '최근 본 의류'],
    ['myBoardIcon.png', '내 게시글'],
    ['settingIcon.png', '설정'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Center(
                  child: Column(
                    children: [
                      MakeCircleImage(
                        imageUrl:
                            'https://i.ytimg.com/vi/gpFSXXhonVk/maxresdefault.jpg',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '난 밤이야 슈밤',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
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
                for (var i = 0; i < 7; i++)
                  Column(
                    children: [
                      ListTile(
                        leading: Image.asset(
                          '$baseAddress${settings[i][0]}',
                          width: 28,
                          height: 28,
                        ),
                        title: Text(settings[i][1]),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FridgeInventoryScreen()));
                        },
                      ),
                      // 마지막에는 생성 X
                      i != 6
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
