class CommentModel {
  final int commentId, memberId;
  final bool isMine;
  final String content, createdAt, nickname, memberProfile;

  CommentModel.fromJson(Map<String, dynamic> json)
      : commentId = json['commentId'],
        memberId = json['memberId'],
        isMine = json['isMine'],
        nickname = json['nickname'],
        memberProfile = json['memberProfile'] ??
            "https://mblogthumb-phinf.pstatic.net/MjAyMDExMDFfMTgy/MDAxNjA0MjI4ODc1NDMw.Ex906Mv9nnPEZGCh4SREknadZvzMO8LyDzGOHMKPdwAg.ZAmE6pU5lhEdeOUsPdxg8-gOuZrq_ipJ5VhqaViubI4g.JPEG.gambasg/%EC%9C%A0%ED%8A%9C%EB%B8%8C_%EA%B8%B0%EB%B3%B8%ED%94%84%EB%A1%9C%ED%95%84_%ED%95%98%EB%8A%98%EC%83%89.jpg?type=w800",
        content = json['content'],
        createdAt = json['createdAt'];
}
