import 'package:ollive_front/models/cloth/cloth_model.dart';

class ClothListModel {
  List<ClothModel> outerList, topList, bottomList, shoesList;

  ClothListModel.fromJson(Map<String, dynamic> json)
      : outerList = (json['outer'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        topList = (json['top'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        bottomList = (json['bottom'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList(),
        shoesList = (json['shoes'] as List<dynamic>)
            .map((comment) => ClothModel.fromJson(comment))
            .toList();
}
