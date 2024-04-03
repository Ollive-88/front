import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ollive_front/models/cloth/cloth_list_model.dart';
import 'package:ollive_front/service/cloth/cloth_service.dart';
import 'package:ollive_front/util/error/error_service.dart';
import 'package:ollive_front/widgets/cloth/cloth_list_widget.dart';

// ignore: must_be_immutable
class ClothListScreen extends StatefulWidget {
  ClothListScreen(
      {super.key,
      required this.outing,
      required this.sing,
      required this.position});

  String outing, sing;
  Position position;

  @override
  State<ClothListScreen> createState() => _ClothListScreenState();
}

class _ClothListScreenState extends State<ClothListScreen> {
  late Future<ClothListModel>? clothList;

  @override
  void initState() {
    super.initState();

    clothList = ClothService.getRecommendClothList(widget.outing, widget.sing,
            widget.position.longitude, widget.position.latitude)
        // ignore: body_might_complete_normally_catch_error
        .catchError((onError) {
      ErrorService.showToast("잘못된 요청입니다.");
    });
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                      category: "아우터",
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
                child: CircleAvatar(
                  backgroundColor: Color(0xFFFFFFFC),
                  backgroundImage:
                      AssetImage("./assets/image/loding/Loding.gif"),
                  radius: 60,
                ),
              );
            }
          }),
    );
  }
}
