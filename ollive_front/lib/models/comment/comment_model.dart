class CommentModel {
  final int commentId, memberId;
  final bool isMine;
  final String content, createdAt, nickname, memberProfile;

  CommentModel.fromJson(Map<String, dynamic> json)
      : commentId = json['commentId'],
        memberId = json['memberId'],
        isMine = json['isMine'],
        nickname = json['nickname'],
        memberProfile = json['memberProfile'],
        content = json['content'],
        createdAt = json['createdAt'];
}
