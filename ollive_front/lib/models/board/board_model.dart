class BoardModel {
  final String title;
  final int boardId, viewCnt, likeCnt, commentCnt;
  final List<String> tags;
  final List<String> imgUrls;

  BoardModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        boardId = json['boardId'],
        viewCnt = json['viewCnt'],
        likeCnt = json['likeCnt'],
        commentCnt = json['commentCnt'],
        tags = List<String>.from(json['tags']),
        imgUrls = List<String>.from(json['imgUrls']);
}
