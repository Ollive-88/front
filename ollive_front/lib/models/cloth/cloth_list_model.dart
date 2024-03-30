import 'package:ollive_front/models/cloth/cloth_model.dart';

class ClothListModel {
  List<ClothModel> outerList, topList, bottomList, shoesList;

  ClothListModel.fromJson(Map<String, dynamic> json)
      : outerList = (json['outerList'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        topList = (json['topList'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        bottomList = (json['bottomList'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        shoesList = (json['shoesList'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList();
}
