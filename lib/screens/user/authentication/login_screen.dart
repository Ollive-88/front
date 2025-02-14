import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/provider/provider.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';
import 'package:ollive_front/widgets/user/user_info_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Map<String, dynamic> info = {'id': 'hi', 'password': 'hi'};

  final Login _userInfo = Login.fromUserInput();
  bool _formChanged = false; // 폼의 UI 상태 관리
  bool _isEmpty = false;

  // // 폼의 현재 상태 관리
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // TextField 관리
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // 활성화 상태 관리
  late FocusNode idFocusNode;
  late FocusNode passwordFocusNode;
  Color idIconColor = Colors.grey;
  Color passwordIconColor = Colors.grey;

  bool isSuccess = false;

  final storage =
      const FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  // storage에 있는 토큰 값 저장
  dynamic accessToken = '';
  dynamic refreshToken = '';

  @override
  void initState() {
    super.initState();

    // 포커스 노드 관리
    idFocusNode = FocusNode()
      ..addListener(() {
        setState(() {
          idIconColor = idFocusNode.hasFocus ? Colors.black87 : Colors.grey;
        });
      });

    passwordFocusNode = FocusNode()
      ..addListener(() {
        setState(() {
          passwordIconColor =
              passwordFocusNode.hasFocus ? Colors.black87 : Colors.grey;
        });
      });

    // 비동기로 flutter secure storage 정보를 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF30AF98),
      minimumSize: const Size(0, 64),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 25,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/image/ollive_logo.png',
                      width: 100,
                      height: 35,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    onChanged: _onFormChange, // 폼 필드가 바뀌면 호출
                    child: Column(
                      children: <Widget>[
                        CustomTextFormField(
                          hint: '아이디',
                          controller: _idController,
                          prefixIcon: Icon(
                            Icons.account_circle_outlined,
                            color: idIconColor,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          focusNode: idFocusNode,
                          suffixIcon: _idController.text.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.cancel),
                                  color: Colors.grey.shade400,
                                  onPressed: () {
                                    _idController.clear();
                                    // 포커스를 텍스트 필드로
                                    idFocusNode.requestFocus();
                                  },
                                ),
                          onSaved: (String? val) => _userInfo.email = val!,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          hint: '비밀번호',
                          controller: _passwordController,
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color: passwordIconColor,
                          ),
                          focusNode: passwordFocusNode,
                          obscureText: true,
                          suffixIcon: _passwordController.text.isEmpty
                              ? null
                              : IconButton(
                                  icon: const Icon(Icons.cancel),
                                  color: Colors.grey.shade400,
                                  onPressed: () {
                                    _passwordController.clear();
                                    // 포커스를 텍스트 필드로
                                    passwordFocusNode.requestFocus();
                                  },
                                ),
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (String? val) => _userInfo.password = val!,
                        ),
                        _isEmpty
                            ? const Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다.\n입력하신 내용을 다시 확인해주세요.',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: buttonStyle,
                                onPressed: _formChanged
                                    ? () async {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          // 로그인 요청 보내기
                                          if (await UserController()
                                              .login(_userInfo)) {
                                            // 로그인 성공이므로 홈페이지로 이동
                                            Navigator.popAndPushNamed(
                                                // ignore: use_build_context_synchronously
                                                context,
                                                '/home');
                                          } else {
                                            // 로그인 실패하면 에러메시지 띄우기
                                            setState(() {
                                              _isEmpty = true;
                                            });
                                            // 모든 포커스 해제
                                            // ignore: use_build_context_synchronously
                                            FocusScope.of(context).unfocus();
                                          }
                                        }
                                      }
                                    // 폼이 변하지 않았다면 버튼 비활성화
                                    : null,
                                child: const Text(
                                  '로그인',
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GestureDetector(
                                onTap: pushSignInPage,
                                child: const Text(
                                  '회원가입',
                                  style: TextStyle(
                                      color: Color(0xFF30AF98),
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFormChange() {
    // 참이면 setState를 호출하지 않아서 플러터가 폼 다시 그리지 않도록 방지
    if (_formChanged) {
      if (_idController.text.isEmpty || _passwordController.text.isEmpty) {
        setState(() {
          _formChanged = false;
        });
      }
    } else {
      if (_idController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty) {
        setState(() {
          // _formChanged에 의존하는 위젯을 다시 그리도록 지시
          _formChanged = true;
        });
      } else if (_idController.text.isEmpty ||
          _passwordController.text.isEmpty) {
        setState(() {});
      }
    }
  }

  void pushSignInPage() {
    Navigator.of(context).pushNamed("/signin");
  }

  _asyncMethod() async {
    // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
    // 데이터가 없을때는 null을 반환
    accessToken = await storage.read(key: 'accessToken');
    refreshToken = await storage.read(key: 'refreshToken');

    // user의 정보가 있다면 게시판으로 이동.
    if (accessToken != null && refreshToken != null) {
      // 전역 Token 값에 accessToken, refreshToken 값 저장
      Get.find<StatusController>().setToken(Token(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ));
      // ignore: use_build_context_synchronously
      Navigator.popAndPushNamed(context, '/home');
    }
  }
}
