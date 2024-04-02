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
        // "outing": outing,
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
    // final response = await _dio.authDio.get(
    //   "/api/v1/cloth/seen",
    //   queryParameters: {
    //     // "outing": outing,
    //     "lastIndex": lastIndex,
    //     "size": size,
    //   },
    // );

    final Map<String, dynamic> result = {
      "cloths": [
        {
          "id": 3590525,
          "rank": 5,
          "score": 0.6252868709173053,
          "product_name": "스포츠 러버 나일론  반집업 크림 DZ0107",
          "brand": "메스타리",
          "brand_english": "MESTARI",
          "product_url": "https://www.musinsa.com/app/goods/3590525",
          "img_url":
              "https://image.msscdn.net/images/goods_img/20230925/3590525/3590525_16956563362637_500.jpg"
        },
        {
          "id": 3909455,
          "rank": 4,
          "score": 0.6258852232918143,
          "product_name": "TWO WAY WINDBREAKER_PURPLE",
          "brand": "샤이선",
          "brand_english": "SHYSON",
          "product_url": "https://www.musinsa.com/app/goods/3909455",
          "img_url":
              "https://image.msscdn.net/images/goods_img/20240228/3909455/3909455_17090972570010_500.jpg"
        },
        {
          "id": 3821857,
          "rank": 3,
          "score": 0.6259769434183836,
          "product_name": "유니크 바시티점퍼 [봄] 핑크",
          "brand": "컬리수",
          "brand_english": "CURLYSUE",
          "product_url": "https://www.musinsa.com/app/goods/3821857",
          "img_url":
              "https://image.msscdn.net/images/goods_img/20240125/3821857/3821857_17062512583847_500.jpg"
        },
        {
          "id": 3591191,
          "rank": 2,
          "score": 0.6265122708901762,
          "product_name": "Sport 2010 Bomber Jacket Brown",
          "brand": "디스이즈네버댓",
          "brand_english": "THISISNEVERTHAT",
          "product_url": "https://www.musinsa.com/app/goods/3591191",
          "img_url":
              "https://image.msscdn.net/images/goods_img/20230925/3591191/3591191_16957092902414_500.jpg"
        },
        {
          "id": 3640240,
          "rank": 1,
          "score": 0.6265409661140292,
          "product_name": "SUNNY COWICHAN CARDIGAN_BLACK",
          "brand": "샤이선",
          "brand_english": "SHYSON",
          "product_url": "https://www.musinsa.com/app/goods/3640240",
          "img_url":
              "https://image.msscdn.net/images/goods_img/20231019/3640240/3640240_16976813754993_500.jpg"
        },
      ]
    };

    List<ClothModel> clothList = (result['cloths']).map<ClothModel>((json) {
      return ClothModel.fromJson(json);
    }).toList();

    return clothList;
  }
}
