import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ollive_front/models/user/user_model.dart';

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
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode focusNode;

  // static const storage =
  //     FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  // dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode(); // 포커스 노드 관리
    // 비동기로 flutter secure storage 정보를 불러오는 작업
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _asyncMethod();
    // });
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

    const baseTopBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.black54,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    );

    const baseBottomBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: Colors.black54,
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
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
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Ollive'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _formKey,
                    onChanged: _onFormChange, // 폼 필드가 바뀌면 호출
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (String? val) => _userInfo.userId = val!,
                          controller: _idController,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.account_circle_outlined),
                            hintText: '아이디',
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF30AF98), width: 2),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            enabledBorder: baseTopBorder,
                          ),
                          autofocus: true, // 이 페이지로 이동했을 때, 자동 포커스
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              setState(() {
                                _isEmpty = true;
                              });
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          obscuringCharacter: '●',
                          controller: _passwordController,
                          onSaved: (String? val) => _userInfo.password = val!,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outlined,
                              color: focusNode.hasFocus
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                            hintText: '비밀번호',
                            enabledBorder: baseBottomBorder,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF30AF98),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                          ),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              setState(() {
                                _isEmpty = true;
                              });
                            }
                            return null;
                          },
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
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: buttonStyle,
                                onPressed: _formChanged
                                    ? () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Get.snackbar(
                                            'title',
                                            'message',
                                            backgroundColor: Colors.white,
                                          );
                                          // loginAction(
                                          //   _userInfo.userId,
                                          //   _userInfo.password,
                                          // );

                                          // 다음 페이지로 이동시키기 (pushedName으로 바꾸기)
                                          // Navigator.pop(context);
                                        } else {
                                          FocusScope.of(context)
                                              .requestFocus(focusNode);
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
      }
    }
  }

  // _asyncMethod() async {
  //   // read 함수로 key값에 맞는 정보를 불러오고 데이터타입은 String 타입
  //   // 데이터가 없을때는 null을 반환
  //   userInfo = await storage.read(key: 'login');

  //   // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
  //   if (userInfo != null) {
  //     Navigator.pushNamed(context, '/main');
  //   } else {
  //     print('로그인이 필요합니다');
  //   }
  // }

  // // 로그인 버튼 누르면 실행
  // loginAction(userId, password) async {
  //   try {
  //     var dio = Dio();
  //     var param = {'user_id': '$userId', 'password': '$password'};

  //     // API URL 바꾸기
  //     Response response = await dio.post('로그인 API URL', data: param);

  //     if (response.statusCode == 200) {
  //       final jsonBody = jsonDecode(response.data);
  //       var val = Login.fromJson(jsonBody);

  //       await storage.write(
  //         key: 'login',
  //         value: jsonEncode(val.toJson()),
  //       );
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }
}
