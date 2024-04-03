import 'package:flutter/material.dart';
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

  final Map<String, String> outing = {
    "편안한 차림으로 나가고 싶어요": "casual",
    "포멀하게 입고 싶어요": "formal",
    "운동하러 가고 싶어요": "sporty",
    "데이트하러 가고싶어요": "fancy",
  };

  final List<String> outingWord = [
    "",
    "편안한 차림으로 나가고 싶어요",
    "포멀하게 입고 싶어요",
    "운동하러 가고 싶어요",
    "데이트하러 가고싶어요",
  ];

  int selectedOuting = 0;

  void changeOuting(int index) {
    selectedOuting = index;
    setState(() {});
  }

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
          centerTitle: true,
          title: const Text(
            "코디 어때?",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        color: const Color(0xFFEBEBE9),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style:
                            const ButtonStyle(alignment: Alignment.centerLeft),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFFFFFC),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    // 상단바
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 15,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "외출 목적을 선택해 주세요.",
                                            style: TextStyle(fontSize: 22),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      thickness: 2,
                                      height: 1,
                                      color: Color(0xFFEBEBE9),
                                    ),
                                    for (var i = 1; i < outingWord.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          changeOuting(i);
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 10,
                                          ),
                                          child: Text(
                                            outingWord[i],
                                            style: const TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Text(
                          outingWord[selectedOuting],
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
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
                        cursorColor: const Color(0xFFFFD5D5),
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
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        if (_singController.text.isEmpty) {
                          ErrorService.showToast("노래가사를 입력해주세요.");
                        } else if (selectedOuting == 0) {
                      ErrorService.showToast("외출목적을 선택해 주세요.");
                    } else {
                          dynamic position = await ClothService.getPosition();

                          if (position is Position) {
                            Navigator.push(
                              // ignore: use_build_context_synchronously
                              context,
                              MaterialPageRoute(
                                builder: (context) => ClothListScreen(
                                  outing: outing[outingWord[selectedOuting]]!,
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
                        height: 65,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFD5D5),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
