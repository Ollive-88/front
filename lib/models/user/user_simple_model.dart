class UserSimpleModel {
  String nickname;
  String? imgUrl;

  UserSimpleModel.fromJson(Map<String, dynamic> json)
      : nickname = json['nickname'],
        imgUrl = json['imgUrl'];

  UserSimpleModel.fromJsonmypage(Map<String, dynamic> json)
      : nickname = json['nickname'],
        imgUrl = json['profilePicture'];
}
