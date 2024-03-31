import 'package:flutter/material.dart';
import 'package:ollive_front/models/user/user_model.dart';
import 'package:ollive_front/service/user/user_service.dart';
import 'package:ollive_front/widgets/user/user_info_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SignIn _userInfo = SignIn.fromUserInput();

  // 폼의 현재 상태 관리
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isGenderSelected = true;
  bool isVisible = false;
  String? _gender;

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
      appBar: AppBar(),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CustomTextFormField(
                            hint: '아이디',
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.grey,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? val) => _userInfo.email = val!,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '아이디: 필수 정보입니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            hint: '비밀번호',
                            obscureText: true,
                            prefixIcon: const Icon(
                              Icons.lock_outlined,
                              color: Colors.grey,
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (String? val) => _userInfo.password = val!,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '비밀번호: 필수 정보입니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFormField(
                            hint: '이름',
                            prefixIcon: const Icon(
                              Icons.account_circle_outlined,
                              color: Colors.grey,
                            ),
                            keyboardType: TextInputType.name,
                            onSaved: (String? val) => _userInfo.name = val!,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '이름: 필수 정보입니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            hint: '생년월일 8자리',
                            prefixIcon: const Icon(
                              Icons.perm_contact_calendar_outlined,
                              color: Colors.grey,
                            ),
                            keyboardType: TextInputType.datetime,
                            onSaved: (String? val) =>
                                _userInfo.birthday = formatBirthDate(val!),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return '생년월일: 필수 정보입니다.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isGenderSelected
                                    ? Colors.black
                                    : const Color(0xFFb3261e),
                                width: isGenderSelected ? 1 : 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text('남자'),
                                    leading: Radio<String>(
                                      value: 'male',
                                      activeColor: const Color(0xFF30AF98),
                                      groupValue: _gender,
                                      onChanged: (String? val) {
                                        setState(() {
                                          _gender = 'male';
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('여자'),
                                    leading: Radio<String>(
                                      value: 'female',
                                      activeColor: const Color(0xFF30AF98),
                                      groupValue: _gender,
                                      onChanged: (String? val) {
                                        setState(() {
                                          _gender = 'female';
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          isVisible
                              ? const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '성별: 성별을 선택해 주세요.',
                                        style: TextStyle(
                                          color: Color(0xFFb3261e),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: buttonStyle,
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate() &&
                                        _gender != null) {
                                      _formKey.currentState!.save();
                                      _userInfo.gender = _gender!;
                                      // 회원가입 요청 보내기
                                      if (await UserService.registerUser(
                                          _userInfo)) {
                                        // 다음 페이지로 이동시키기 (pushedName으로 바꾸기)
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      if (_gender == null) {
                                        setState(() {
                                          isVisible = true;
                                          isGenderSelected = false;
                                        });
                                      } else {
                                        setState(() {
                                          isVisible = false;
                                          isGenderSelected = true;
                                        });
                                      }
                                    }
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

  String formatBirthDate(String input) {
    // 입력 문자열을 연도, 월, 일로 분리
    String year = input.substring(0, 4);
    String month = input.substring(4, 6);
    String day = input.substring(6);

    // 생년월일 형식으로 조합하여 반환
    return '$year-$month-$day';
  }
}
