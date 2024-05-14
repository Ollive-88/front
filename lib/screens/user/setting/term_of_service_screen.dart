import 'package:flutter/material.dart';

class TermOfServiceScreen extends StatelessWidget {
  TermOfServiceScreen({super.key});

  final List<String> textList = [
    '[올리브 이용 약관]',
    '제1조 (목적)\n이 약관은 전기통신사업법령 및 정보통신망이용촉진, 전자상거래 등에 관한 법령에 의하여 올리브가 제공하는 올리브의 서비스 이용과 관련하여 회사와 회원과의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.',
    '제2조 (약관의 효력 및 변경)\n① 이 약관은 회사가 그 내용을 서비스 초기 화면을 통해 게시하고 이용자가 이에 동의를 함으로써 효력을 발생합니다.\n② 회사는 합리적인 사유가 있을 경우 약관규제에 관한 법률, 정보통신망 이용촉진 및 정보보호등에 관한 법률 등 관련법을 위배하지 않는 범위에서 본 약관을 변경할 수 있으며, 이 경우 적용일자 및 개정사유를 명시하여 현행약관과 함께 만개의레시피의 서비스 초기 화면에 그 적용일자 7일이전부터 적용일자 전일까지 공지합니다. 다만, 이용자에게 불리하게 약관내용을 변경하는 경우에는 최소한 30일 이상의 사전 유예기간을 두고 공지합니다.\n③ 변경된 약관은 그 내용이 법령에 위배되지 않는 한 변경 이전에 회원으로 가입한 이용자에게도 적용됩니다. 변경된 약관에 이의가 있는 회원은 회사가 정한 양식에 따라 언제든지 회원등록을 취소(회원탈퇴)할 수 있으며, 약관의 효력발생일 이후의 계속적인 서비스 이용은 약관의 변경사항에 동의한 것으로 간주됩니다.',
    '제3조 (약관 외 준칙)\n① 이 약관은 회사가 제공하는 서비스에 관한 이용규정 및 별도 약관과 함께 적용 됩니다.\n② 이 약관에 명시되지 않은 사항과 이 약관의 해석에 관하여는 관련법령 및 상관례에 따릅니다.',
    '제4조 (용어의 정의)\n1. 이용자 : 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.\n2. 회원 : 회사에 일정한 개인정보를 제공하여 이용계약을 체결하고 아이디(ID)를 부여 받은 개인,회사,단체로 회사가 제공하는 서비스(제휴업체가 제공하는 서비스 제외)를 이용할 수 있는 자를 말합니다.\n3. 비회원 : 회원에 가입하지 않고 회사가 제공하는 서비스를 이용하는 자를 말합니다.\n4. 비밀번호 : 회원의 본인확인과 비밀보호를 위하여 선정한 문자, 숫자 또는 양자의 조합\n5. 이용계약 : 서비스를 제공받기 위하여 이 약관으로 회사와 회원간에 체결하는 계약\n6. 계약해지 : 회사 또는 회원이 서비스 개통 후 이용계약을 해약하는 것\n7. 이용자 : 회사가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.',
    '제5조 (이용계약의 성립)\n① 서비스 가입 신청 시 본 약관을 읽고 "동의" 버튼을 누르면 이 약관에 동의하는 것으로 간주 됩니다.\n② 이용계약은 서비스 이용 희망자의 이용약관 동의 후 이용신청에 대하여 회사가 승낙함으로써 성립합니다.',
  ];

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
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var text in textList)
                    Column(
                      children: [
                        Text(
                          text,
                          style: const TextStyle(height: 1.6),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
