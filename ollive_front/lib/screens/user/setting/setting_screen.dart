import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ollive_front/screens/user/setting/term_of_service_screen.dart';
import 'package:ollive_front/screens/user/setting/term_of_userinfo_screen.dart';
import 'package:ollive_front/screens/user/setting/unregister_screen.dart';
import 'package:ollive_front/screens/user/setting/update_profile_image_screen.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  static String baseAddress = 'assets/image/icons/';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final List<dynamic> settings = [
    '비밀번호 변경',
    '닉네임 변경',
    '프로필사진 변경',
    '개인정보 처리방침',
    '서비스 이용약관',
    '로그아웃',
    '회원탈퇴',
  ];

  final List<Widget> pages = [
    TermOfServiceScreen(),
    TermOfServiceScreen(),
    const ProfileImageScreen(),
    const TermOfUserInfoScreen(),
    TermOfServiceScreen(),
    TermOfServiceScreen(),
    UnregisterScreen(),
  ];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  final storage = const FlutterSecureStorage();

  final StatusController _userInfoController = Get.put(StatusController());

  void logout(BuildContext context) {
    UserService.logoutAction().then((value) async {
      await storage.delete(key: 'accessToken');
      await storage.delete(key: 'refreshToken');
      _userInfoController
          .setToken(Token(accessToken: null, refreshToken: null));
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    });
  }

  void updatePassword(BuildContext context, List input) {
    UserService.updateUserInfo(input).then((value) {
      _passwordController.clear();
      Navigator.of(context).pop();
    }).catchError((e) {});
  }

  void updateNickname(BuildContext context, List input) {
    UserService.updateUserInfo(input).then((value) {
      _userInfoController.setNickname(input[1]);
      Navigator.of(context).pop();
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '설정',
        ),
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < 7; i++)
                Column(
                  children: [
                    ListTile(
                      title: Text(settings[i]),
                      onTap: () {
                        if (i == 0) {
                          showdialog(context, '비밀번호 수정', _passwordController,
                              true, '새 비밀번호', true, () {
                            updatePassword(context,
                                ['password', _passwordController.text]);
                          });
                        } else if (i == 1) {
                          _nicknameController.text =
                              _userInfoController.nickname;
                          showdialog(context, '닉네임 수정', _nicknameController,
                              false, '닉네임을 입력하세요.', true, () {
                            updateNickname(context,
                                ['nickname', _nicknameController.text]);
                          });
                        } else if (i == 5) {
                          showdialog(context, '로그아웃 하시겠습니까?',
                              TextEditingController(), false, '', false, () {
                            logout(context);
                          });
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => pages[i],
                            ),
                          );
                        }
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
    );
  }

  Future<dynamic> showdialog(
    BuildContext context,
    String title,
    TextEditingController controller,
    bool isObscure,
    String hintText,
    bool textTrue,
    pressAction,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsPadding: const EdgeInsets.only(
          top: 0,
          bottom: 10,
          right: 10,
          left: 10,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: const Color(0xFFFFFFFC),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: textTrue
            ? SizedBox(
                width: 180,
                child: TextField(
                  autofocus: true,
                  obscureText: isObscure,
                  obscuringCharacter: '●',
                  controller: controller,
                  style: const TextStyle(fontSize: 14),
                  cursorColor: const Color(0xFF30AF98),
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        borderSide: BorderSide(color: Color(0xFF30AF98))),
                  ),
                ),
              )
            : const SizedBox(),
        actions: [
          TextButton(
              onPressed: () {
                controller.clear();
                Navigator.of(context).pop();
              },
              child: const Text(
                '취소',
                style: TextStyle(color: Colors.black54),
              )),
          TextButton(
              onPressed: () {
                pressAction();
              },
              child: const Text('확인',
                  style: TextStyle(
                      color: Color(0xFF30AF98), fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  void showToast(context, msg) {
    FocusScope.of(context).unfocus();
    // 약간의 딜레이 후에 토스트 메시지를 띄운다.
    Future.delayed(const Duration(milliseconds: 100), () {
      Fluttertoast.showToast(
        msg: msg,
      );
    });
  }
}
