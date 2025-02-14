import 'package:geolocator/geolocator.dart';
import 'package:ollive_front/models/cloth/cloth_list_model.dart';
import 'package:ollive_front/models/cloth/cloth_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class ClothService {
  static final DioService _dio = DioService();

  static Future<dynamic> getPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      return position;
    } catch (e) {
      return null;
    }
  }

  static Future<ClothListModel> getRecommendClothList(
      String outing, String sing, double longitude, double latitude) async {
    final response = await _dio.authDio.post(
      "/api/v1/cloth/recommendation",
      data: {
        "goal": outing,
        "text": sing,
        "longitude": longitude,
        "latitude": latitude,
      },
    );

    ClothListModel clothList = ClothListModel.fromJson(response.data);

    return clothList;
  }

  static Future<void> postCloth(int clothId) async {
    await _dio.authDio.post(
      "/api/v1/cloth/$clothId",
    );
  }

  static Future<List<ClothModel>> getSeenClothesList(
      int lastIndex, int size) async {
    final response = await _dio.authDio.get(
      "/api/v1/cloth/seen",
      queryParameters: {
        "lastIndex": lastIndex,
        "size": size,
      },
    );
    List<ClothModel> clothList =
        (response.data['clothes']).map<ClothModel>((json) {
      return ClothModel.fromJson(json);
    }).toList();

    return clothList;
  }
}
