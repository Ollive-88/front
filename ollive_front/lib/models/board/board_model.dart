class BoardModel {
  final String title, content, thumbnailAddress, createdAt;
  final int boardId, views, commentCount;
  int likes;
  final List<String> tags;

  BoardModel.fromJson(Map<String, dynamic> json)
      : boardId = json['boardId'],
        title = json['title'],
        content = json['content'],
        thumbnailAddress = json['thumbnailAddress'],
        createdAt = json['createdAt'],
        commentCount = json['commentCount'],
        likes = json['likes'],
        views = json['views'],
        tags = List<String>.from(json['tags']);
}
        // boardId = json['boardId'],
        // isLiked = json['isLiked'],
        // isViewed = json['isViewed'],

      //   List<BoardModel> instance = (response.data).map<BoardModel>((json) {
      //   return BoardModel.fromJson(json);
      // }).toList();