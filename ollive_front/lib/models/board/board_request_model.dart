class BoardRequestModel {
  final String? keyword;
  final List<String>? tags;
  final int page, sort;

  BoardRequestModel(
      {this.keyword, this.tags, required this.page, required this.sort});
}
