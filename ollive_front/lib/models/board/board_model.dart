class Board {
  final String title;
  final int viewCnt, likeCnt, commentCnt;
  final List<String> tags;
  final List<String> imgUrls;

  Board.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        viewCnt = json['viewCnt'],
        likeCnt = json['likeCnt'],
        commentCnt = json['commentCnt'],
        tags = List<String>.from(json['tags']),
        imgUrls = List<String>.from(json['imgUrls']);
}
