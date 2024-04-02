import 'package:flutter/material.dart';

class TermOfUserInfoScreen extends StatelessWidget {
  const TermOfUserInfoScreen({super.key});

  final String text =
      '올리브는 개인정보 보호법 제30조에 따라 회사의 서비스를 이용하는 회원의 개인정보를 보호하고 이와 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보 처리지침을 수립·공개합니다.\n1. 총칙\n2. 수집하는 개인정보의 항목 및 수집방법\n3. 개인정보 수집에 대한 동의\n4. 개인정보의 수집목적 및 이용목적\n5. 쿠키에 의한 개인정보 수집\n6. 개인정보 제공\n7. 개인정보의 열람·정정\n8. 개인정보 수집, 이용, 제공에 대한 동의철회\n9. 개인정보의 보유기간 및 이용기간, 파기절차, 파기방법\n10. 개인정보보호를 위한 기술 및 관리적 대책\n11. 링크사이트\n12. 게시물\n13. 개인정보의 위탁처리\n14. 형태정보 제공에 대한 메체사 고지\n15. 이용자의 권리와 의무 및 법정대리인의 권리·의무 및 행사방법\n16. 개인정보관리책임자 및 담당자\n17. 광고성 정보전송\n18. 정책 변경에 따른 고지의무\n제1조 총칙\n１. 개인정보란 생존하는 개인에 관한 정보로서 해당 정보에 포함되어 있는 이름, 연락처 등의 사항에 의하여 개인을 식별할 수 있는 정보를 말합니다.\n２. 회사는 이용자의 개인정보를 소중히 취급하며 정보통신망 이용촉진 및 정보보호 등에 관한 법률상의 개인정보보호규정 및 정보통신부가 제정한 개인정보보호지침을 준수하고 있습니다. 회사는 개인정보취급방침을 통하여 이용자가 제공하는 개인정보가 어떠한 목적과 방식으로 이용되고 있으며 개인정보보호를 위해 어떠한 조치가 취해지고 있는지 알려드립니다.\n３. 회사는 개인정보취급방침을 홈페이지 첫 화면에 공개함으로써 이용자가 언제나 용이하게 확인할 수 있도록 조치하고 있습니다.\n４. 회사는 개인정보취급방침의 지속적인 개선을 위하여 개인정보취급방침을 개정하는데 필요한 절차를 정하고 있습니다.';

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
                  Text(
                    text,
                    style: const TextStyle(height: 1.6),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
