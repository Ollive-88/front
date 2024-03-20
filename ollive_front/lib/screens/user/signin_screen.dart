import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ollive_front/models/user/user_model.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // Map<String, dynamic> info = {'id': 'hi', 'password': 'hi'};

  final Login _userInfo = Login.fromUserInput();
  bool _formChanged = false; // 폼의 UI 상태 관리
  bool isIdError = false;
  bool isPasswordError = false;
  bool isNameError = false;
  bool isBirthError = false;
  bool isGenderSelected = false;

  // 폼의 현재 상태 관리
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode focusNode;
  bool isManSelected = false;
  bool isWomanSelected = false;
  Map<String, String> errorMessages = {};

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: const Color(0xFF30AF98),
                            // onSaved: (String? val) => _userInfo.userId = val!,
                            decoration: InputDecoration(
                              prefixIcon:
                                  prefixIcon(Icons.account_circle_outlined),
                              hintText: '아이디',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                            ),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                setState(() {
                                  isIdError = true;
                                });
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            obscuringCharacter: '●',
                            cursorColor: const Color(0xFF30AF98),
                            // onSaved: (String? val) => _userInfo.password = val!,
                            decoration: InputDecoration(
                              prefixIcon: prefixIcon(Icons.lock_outlined),
                              hintText: '비밀번호',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                              ),
                            ),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                setState(() {
                                  isPasswordError = true;
                                });
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.name,
                            cursorColor: const Color(0xFF30AF98),
                            // onSaved: (String? val) => _userInfo.userId = val!,
                            decoration: InputDecoration(
                              prefixIcon:
                                  prefixIcon(Icons.account_circle_outlined),
                              hintText: '이름',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(15),
                                ),
                              ),
                            ),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                setState(() {
                                  isNameError = true;
                                });
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            keyboardType: TextInputType.datetime,
                            cursorColor: const Color(0xFF30AF98),
                            // onSaved: (String? val) => _userInfo.userId = val!,
                            decoration: InputDecoration(
                              prefixIcon: prefixIcon(
                                  Icons.perm_contact_calendar_outlined),
                              hintText: '생년월일 8자리',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.zero,
                              ),
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.zero),
                            ),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                setState(() {
                                  isBirthError = true;
                                });
                              }
                              return null;
                            },
                          ),
                          Container(
                            height: 64,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(15),
                                ),
                                border: Border.all(
                                  color: Colors.black,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: manSelect,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: isManSelected
                                              ? const Color(0xFF30AF98)
                                              : Colors.black54,
                                          width: isManSelected ? 2 : 1,
                                        ),
                                        foregroundColor: Colors.grey,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        '남자',
                                        style: TextStyle(
                                          color: isManSelected
                                              ? const Color(0xFF30AF98)
                                              : Colors.black54,
                                          fontWeight: isManSelected
                                              ? FontWeight.w900
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: womanSelect,
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: isWomanSelected
                                              ? const Color(0xFF30AF98)
                                              : Colors.black54,
                                          width: isWomanSelected ? 2 : 1,
                                        ),
                                        foregroundColor: Colors.grey,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        '여자',
                                        style: TextStyle(
                                          color: isWomanSelected
                                              ? const Color(0xFF30AF98)
                                              : Colors.black54,
                                          fontWeight: isWomanSelected
                                              ? FontWeight.w900
                                              : FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: buttonStyle,
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      // loginAction(
                                      //   _userInfo.userId,
                                      //   _userInfo.password,
                                      // );

                                      // 다음 페이지로 이동시키기 (pushedName으로 바꾸기)
                                      // Navigator.pop(context);
                                    } else {
                                      Get.snackbar('title', 'message');
                                    }
                                    // else {
                                    //   FocusScope.of(context)
                                    //       .requestFocus(focusNode);
                                    // }
                                  },
                                  child: const Text(
                                    '인증요청',
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
    if (_formChanged) return;
    setState(() {
      // _formChanged에 의존하는 위젯을 다시 그리도록 지시
      _formChanged = true;
    });
  }

  void manSelect() {
    if (!isGenderSelected) {
      isGenderSelected = true;
    }
    if (!isManSelected) {
      setState(() {
        isManSelected = true;
        isWomanSelected = false;
      });
    }
  }

  void womanSelect() {
    if (!isGenderSelected) {
      isGenderSelected = true;
    }
    if (!isWomanSelected) {
      setState(() {
        isManSelected = false;
        isWomanSelected = true;
      });
    }
  }

  void checkErrors(val) {
    if (val.isEmpty) {
      setState(() {
        isNameError = true;
      });
    }
  }

  Widget prefixIcon(IconData icon) {
    return Icon(
      icon,
      color: Colors.grey,
    );
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
