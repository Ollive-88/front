import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class UnregisterScreen extends StatelessWidget {
  UnregisterScreen({super.key});

  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFF30AF98),
    minimumSize: const Size(0, 50),
    foregroundColor: Colors.white,
    textStyle: const TextStyle(
      fontSize: 20,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final StatusController _userInfoController = Get.put(StatusController());
  final storage = const FlutterSecureStorage();
  bool isComplet = false;

  void removeMembership(BuildContext context) {
    if (!isComplet) {
      isComplet = true;
      UserService.deleteUserInfo().then((value) async {
        await storage.delete(key: 'accessToken');
        await storage.delete(key: 'refreshToken');
        _userInfoController
            .setToken(Token(accessToken: null, refreshToken: null));

        Navigator.pushNamedAndRemoveUntil(
            context, '/login', (Route<dynamic> route) => false);
      });
      isComplet = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf1f1f1),
      appBar: AppBar(
        title: const Text('생활의 모든 것. Ollive.'),
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const Row(
              children: [
                Text(
                  '회원탈퇴',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        '탈퇴하면 앞으로 이 계정으로 로그인할 수 없고 이 계정을 다시 복구할 수 없습니다.'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('* 가입정보를 변경하고 싶다면 회원정보수정에서 변경할 수 있습니다.'),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      '탈퇴하려면 아래 확인 버튼을 클릭해주세요.',
                      style: TextStyle(
                          fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: buttonStyle,
                            onPressed: () {
                              removeMembership(context);
                            },
                            child: const Text(
                              '확인',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
