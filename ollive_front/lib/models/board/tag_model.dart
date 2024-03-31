class TagModel {
  int? id;
  String tagName;

  TagModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tagName = json['tagName'];

  TagModel(this.tagName);
}
