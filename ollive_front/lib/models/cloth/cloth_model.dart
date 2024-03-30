class ClothModel {
  String name, category, url, imgUrl;

  ClothModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        category = json['category'],
        url = json['url'],
        imgUrl = json['imgUrl'];
}
