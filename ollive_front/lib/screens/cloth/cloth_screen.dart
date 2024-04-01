import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ollive_front/screens/cloth/cloth_list_screen.dart';
import 'package:ollive_front/service/cloth/cloth_service.dart';
import 'package:ollive_front/util/error/error_service.dart';

class ClothScreen extends StatefulWidget {
  const ClothScreen({super.key});

  @override
  State<ClothScreen> createState() => _ClothScreenState();
}

class _ClothScreenState extends State<ClothScreen> {
  final TextEditingController _outingController = TextEditingController();
  final TextEditingController _singController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFC),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / 10,
          backgroundColor: const Color(0xFFFFFFFC),
          title: const Center(
            child: Text(
              "코디 어때?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 소개글
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '외출 목적과 좋아하는 노래가사를',
                            style: TextStyle(
                              color: Color(0xFFFFD5D5),
                            ), // 변경할 색상
                          ),
                          TextSpan(text: ' 알려주시면 '),
                          TextSpan(
                            text: '최적의 패션',
                            style: TextStyle(
                              color: Color(0xFFFFD5D5),
                            ), // 변경할 색상
                          ),
                          TextSpan(text: '을 추천해 드릴게요'),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "  외출 목적",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFFD5D5),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFFEBEBE9)),
                      // ignore: deprecated_member_use
                      child: TextField(
                        controller: _outingController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    const Text(
                      "  노래 가사",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFFFD5D5),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFFEBEBE9)),
                      // ignore: deprecated_member_use
                      child: TextField(
                        controller: _singController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                child: GestureDetector(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    if (_singController.text.isEmpty) {
                      ErrorService.showToast("노래가사를 입력해주세요.");
                    } else {
                      dynamic position = await ClothService.getPosition();

                      if (position is Position) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClothListScreen(
                              outing: _outingController.text,
                              sing: _singController.text,
                              position: position,
                            ),
                          ),
                        );
                      } else {
                        ErrorService.showToast("위치 정보를 동의해 주세요.");
                      }
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.1,
                    height: MediaQuery.of(context).size.height / 11,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD5D5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "검색",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
