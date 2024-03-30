import 'package:flutter/material.dart';
import 'package:ollive_front/models/cloth/cloth_model.dart';
import 'package:ollive_front/widgets/cloth/cloth_widget.dart';

// ignore: must_be_immutable
class ClothListWidget extends StatelessWidget {
  ClothListWidget({super.key, required this.category, required this.clothList});
  List<ClothModel> clothList;
  String category;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (ClothModel cloth in clothList)
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: ClothWidget(clothModel: cloth),
                    ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
