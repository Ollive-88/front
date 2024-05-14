import 'package:image_picker/image_picker.dart';

class BoardPostModel {
  final String title, content;
  final List<String> tags;
  final List<XFile> imgs;

  BoardPostModel(
      {required this.title,
      required this.content,
      required this.tags,
      required this.imgs});
}
