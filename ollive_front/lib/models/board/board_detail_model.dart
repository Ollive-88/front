import 'package:ollive_front/models/comment/comment_model.dart';
import 'package:ollive_front/models/user/user_simple_model.dart';

class BoardDetailModel {
  final String title, content, createdAt;
  final int boardId, viewCount;
  int likeCount;
  bool isMine, isLiked;
  final UserSimpleModel writer;
  final List<String> tags;
  final List<String> images;
  final List<CommentModel> comments;

  BoardDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        createdAt = json['createdAt'],
        boardId = json['boardId'],
        viewCount = json['viewCount'],
        likeCount = json['likeCount'],
        isLiked = json['isLiked'],
        isMine = json['isMine'],
        writer = UserSimpleModel.fromJson(json['writer']),
        tags = List<String>.from(json['tags']),
        images = List<String>.from(json['images']),
        comments = (json['comments'] as List<dynamic>)
            .map((comment) => CommentModel.fromJson(comment))
            .toList();
}
