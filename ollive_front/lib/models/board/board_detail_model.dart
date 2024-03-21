import 'package:ollive_front/models/comment/comment_model.dart';
import 'package:ollive_front/models/user/user_simple_model.dart';

class BoardDetailModel {
  final String title, content, createdAt;
  final int boardId, viewCnt, likeCnt, commentCnt;
  final bool isLiked, isMine;
  final UserSimpleModel writer;
  final List<String> tags;
  final List<String> imgUrls;
  final List<CommentModel> comments;

  BoardDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        content = json['content'],
        createdAt = json['createdAt'],
        boardId = json['boardId'],
        viewCnt = json['viewCnt'],
        likeCnt = json['likeCnt'],
        commentCnt = json['commentCnt'],
        isLiked = json['isLiked'],
        isMine = json['isMine'],
        writer = UserSimpleModel.fromJson(json['writer']),
        tags = List<String>.from(json['tags']),
        imgUrls = List<String>.from(json['imgUrls']),
        comments = (json['comments'] as List<dynamic>)
            .map((comment) => CommentModel.fromJson(comment))
            .toList();
}
