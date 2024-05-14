import 'package:ollive_front/models/board/image_model.dart';
import 'package:ollive_front/models/board/tag_model.dart';
import 'package:ollive_front/models/comment/comment_model.dart';
import 'package:ollive_front/models/user/user_simple_model.dart';

class BoardDetailModel {
  final String title, content, createdAt;
  final int boardId, viewCount;
  int likeCount;
  bool isMine, isLiked;
  final UserSimpleModel writer;
  final List<TagModel> tags;
  final List<ImageModel> images;
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
        tags = (json['tags'] as List<dynamic>)
            .map((tag) => TagModel.fromJson(tag))
            .toList(),
        images = (json['images'] as List<dynamic>)
            .map((image) => ImageModel.fromJson(image))
            .toList(),
        comments = (json['comments'] as List<dynamic>)
            .map((comment) => CommentModel.fromJson(comment))
            .toList();
}
