class ClothModel {
  int id;
  String name, url, imgUrl;

  ClothModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json['product_name'],
        url = json['product_url'],
        imgUrl = json['img_url'];
}
