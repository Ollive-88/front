import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ollive_front/screens/user/setting/term_of_service_screen.dart';
import 'package:ollive_front/screens/user/setting/unregister_screen.dart';
import 'package:ollive_front/screens/user/setting/update_profile_image_screen.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});

  static String baseAddress = 'assets/image/icons/';
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
    const TermOfServiceScreen(),
    const TermOfServiceScreen(),
    const ProfileImageScreen(),
    const TermOfServiceScreen(),
    const TermOfServiceScreen(),
    const TermOfServiceScreen(),
    const UnregisterScreen(),
  ];

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
        centerTitle: true,
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
                          showdialog(
                            context,
                            '비밀번호 수정',
                            _passwordController,
                            true,
                            '새 비밀번호',
                          );
                        } else if (i == 1) {
                          _nicknameController.text = 'hihi';
                          showdialog(
                            context,
                            '닉네임 수정',
                            _nicknameController,
                            false,
                            '닉네임을 입력하세요.',
                          );
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
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.white,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                obscureText: isObscure,
                obscuringCharacter: '●',
                controller: controller,
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
          ],
        ),
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
                if (controller.text.isEmpty) {
                  showToast(context, '필수값입니다.');
                } else {
                  controller.clear();
                  Navigator.of(context).pop();
                }
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
