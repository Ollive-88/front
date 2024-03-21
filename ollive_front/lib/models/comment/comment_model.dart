import 'package:ollive_front/models/user/user_simple_model.dart';

class CommentModel {
  final String content, createdAt;
  final UserSimpleModel writer;

  CommentModel.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        createdAt = json['createdAt'],
        writer = UserSimpleModel.fromJson(json['writer']);
}
