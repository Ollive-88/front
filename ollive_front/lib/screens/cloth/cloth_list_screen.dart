import 'package:flutter/material.dart';
import 'package:ollive_front/models/cloth/cloth_list_model.dart';
import 'package:ollive_front/service/cloth/cloth_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/cloth/cloth_list_widget.dart';

// ignore: must_be_immutable
class ClothListScreen extends StatefulWidget {
  ClothListScreen({super.key, required this.outing, required this.sing});

  String outing, sing;

  @override
  State<ClothListScreen> createState() => _ClothListScreenState();
}

class _ClothListScreenState extends State<ClothListScreen> {
  late Future<ClothListModel> clothList;

  @override
  void initState() {
    super.initState();
    clothList = ClothService.getRecommendClothList(widget.outing, widget.sing)
        //     .catchError((onError) {
        //   ErrorService.showToast("잘못된 요청입니다.");
        // })
        ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFC),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height / 10,
        centerTitle: true,
        surfaceTintColor: const Color(0xFFFFFFFC),
        shadowColor: Colors.black,
        elevation: 0,
        backgroundColor: const Color(0xFFFFFFFC),
        foregroundColor: Colors.black,
        title: const Text(
          "오늘의 패션",
          style: TextStyle(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
          future: clothList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ClothListWidget(
                      category: "아웃터",
                      clothList: snapshot.data!.outerList,
                    ),
                    ClothListWidget(
                      category: "상의",
                      clothList: snapshot.data!.topList,
                    ),
                    ClothListWidget(
                      category: "하의",
                      clothList: snapshot.data!.bottomList,
                    ),
                    ClothListWidget(
                      category: "신발",
                      clothList: snapshot.data!.shoesList,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
