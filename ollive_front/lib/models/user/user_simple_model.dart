class UserSimpleModel {
  String nickName, imgUrl;

  UserSimpleModel.fromJson(Map<String, dynamic> json)
      : nickName = json['nickName'],
        imgUrl = json['imgUrl'];
}
