import 'package:image_picker/image_picker.dart';

class ImageModel {
  int id;
  String address;

  ImageModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'];
}

class ImageDetailModel {
  int? id;
  String? address;
  XFile imgFile;

  ImageDetailModel({this.id, this.address, required this.imgFile});
}
