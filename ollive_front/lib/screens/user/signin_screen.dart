import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Map<String, dynamic> info = {'id': 'hi', 'password': 'hi'};

  // final Login _userInfo = Login.fromUserInput();
  // bool _formChanged = false; // 폼의 UI 상태 관리
  // // 폼의 현재 상태 관리
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // late FocusNode focusNode;

  // static const storage =
  //     FlutterSecureStorage(); // FlutterSecureStorage를 storage로 저장
  // dynamic userInfo = ''; // storage에 있는 유저 정보를 저장

  // @override
  // void initState() {
  //   super.initState();
  //   focusNode = FocusNode(); // 포커스 노드 관리
  //   // 비동기로 flutter secure storage 정보를 불러오는 작업
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _asyncMethod();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF30AF98),
      minimumSize: const Size(360, 70),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(
        fontSize: 25,
      ),
    );

    const OutlineInputBorder userIdOutlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFF30AF98),
      ),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    // onChanged: _onFormChange, // 폼 필드가 바뀌면 호출
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            // onSaved: (String? val) => _userInfo.userId = val!,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle_outlined),
                              hintText: '아이디',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                            ),
                            autofocus: true, // 이 페이지로 이동했을 때, 자동 포커스
                            // 폼 내용 바꾸기 전에는 실행 X
                            // autovalidateMode: _formChanged
                            //     ? AutovalidateMode.always
                            //     : AutovalidateMode.disabled,
                            // validator: (String? val) {
                            //   if (val!.isEmpty) {
                            //     return "Field cannot be left blank";
                            //   }
                            //   return null;
                            // },
                          ),
                          TextFormField(
                            obscureText: true,

                            // onSaved: (String? val) => _userInfo.password = val!,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outlined),
                              hintText: '비밀번호',
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF30AF98),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                              ),
                              // helperText: 'Required',
                            ),
                            // autovalidateMode: _formChanged
                            //     ? AutovalidateMode.always
                            //     : AutovalidateMode.disabled,
                            // validator: (String? val) {
                            //   if (val!.isEmpty) {
                            //     return "Field cannot be left blank";
                            //   }
                            //   return null;
                            // },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: buttonStyle,
                                onPressed: () {},
                                // onPressed: _formChanged
                                //     ? () {
                                //         if (_formKey.currentState!.validate()) {
                                //           _formKey.currentState!.save();
                                //           loginAction(
                                //             _userInfo.userId,
                                //             _userInfo.password,
                                //           );

                                //           // 다음 페이지로 이동시키기 (pushedName으로 바꾸기)
                                //           Navigator.pop(context);
                                //         } else {
                                //           FocusScope.of(context)
                                //               .requestFocus(focusNode);
                                //         }
                                //       }
                                //     // 폼이 변하지 않았다면 버튼 비활성화
                                //     : null,
                                child: const Text(
                                  '로그인',
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

  // void _onFormChange() {
  //   // 참이면 setState를 호출하지 않아서 플러터가 폼 다시 그리지 않도록 방지
  //   if (_formChanged) return;
  //   setState(() {
  //     // _formChanged에 의존하는 위젯을 다시 그리도록 지시
  //     _formChanged = true;
  //   });
  // }

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
