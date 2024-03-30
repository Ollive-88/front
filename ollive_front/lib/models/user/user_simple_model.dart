class UserSimpleModel {
  String nickname, imgUrl;

  UserSimpleModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        imgUrl = json['imgUrl'];
}
