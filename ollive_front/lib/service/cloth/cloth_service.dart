import 'package:geolocator/geolocator.dart';
import 'package:ollive_front/models/cloth/cloth_list_model.dart';
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
    try {
      final response = await _dio.authDio.post(
        "api/v1/cloth/recommendation",
        data: {
          // "outing": outing,
          "text": sing,
          "longitude": longitude,
          "latitude": latitude,
        },
      );

      ClothListModel clothList = ClothListModel.fromJson(response.data);

      return clothList;
    } catch (e) {
      return ClothListModel.fromJson({
        "outer": [
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
          }
        ],
        "top": [
          {
            "id": 3769135,
            "rank": 5,
            "score": 0.6261377603337168,
            "product_name": "[2PACK] 디지 헤비웨이트 후드 4종 2PACK JUHD4602",
            "brand": "퍼스텝",
            "brand_english": "PERSTEP",
            "product_url": "https://www.musinsa.com/app/goods/3769135",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20231228/3769135/3769135_17037236994544_500.jpg"
          },
          {
            "id": 3879489,
            "rank": 4,
            "score": 0.626420550763607,
            "product_name": "꽃모자 반팔티 블랙",
            "brand": "테디아일랜드",
            "brand_english": "TEDDYISLAND",
            "product_url": "https://www.musinsa.com/app/goods/3879489",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240219/3879489/3879489_17091114765238_500.jpg"
          },
          {
            "id": 3879543,
            "rank": 3,
            "score": 0.62644924598746,
            "product_name": "스포츠리그 반팔티 블랙",
            "brand": "테디아일랜드",
            "brand_english": "TEDDYISLAND",
            "product_url": "https://www.musinsa.com/app/goods/3879543",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240219/3879543/3879543_17086831089999_500.jpg"
          },
          {
            "id": 3448298,
            "rank": 2,
            "score": 0.6265122708901762,
            "product_name": "공용 애슬래틱 클럽 반소매 티셔츠 - 화이트 / TS843WH",
            "brand": "스포티앤리치",
            "brand_english": "SPORTY&RICH",
            "product_url": "https://www.musinsa.com/app/goods/3448298",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20230807/3448298/3448298_16950947852607_500.jpg"
          },
          {
            "id": 3701187,
            "rank": 1,
            "score": 0.6265122708901762,
            "product_name": "빈티지 엠블럼 스웻 셔츠_그린(EN2CFMM448A)",
            "brand": "에노우",
            "brand_english": "ENOU",
            "product_url": "https://www.musinsa.com/app/goods/3701187",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20231109/3701187/3701187_16995143601506_500.jpg"
          }
        ],
        "bottom": [
          {
            "id": 3636761,
            "rank": 5,
            "score": 0.6232720482666045,
            "product_name": "SUN RIVER CORDUROY PANTS_BLUE",
            "brand": "샤이선",
            "brand_english": "SHYSON",
            "product_url": "https://www.musinsa.com/app/goods/3636761",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20231018/3636761/3636761_16976039964280_500.jpg"
          },
          {
            "id": 3663902,
            "rank": 4,
            "score": 0.6233694028481841,
            "product_name": "[CDW] 리베카 후드티 세트",
            "brand": "스타일노리터",
            "brand_english": "STYLE NORITER",
            "product_url": "https://www.musinsa.com/app/goods/3663902",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20231027/3663902/3663902_16983928160722_500.jpg"
          },
          {
            "id": 3625427,
            "rank": 3,
            "score": 0.6239964504465461,
            "product_name": "하트뿜뿜 상하세트 (PTF11ST50M_PK)",
            "brand": "피터젠슨",
            "brand_english": "PETER JENSEN",
            "product_url": "https://www.musinsa.com/app/goods/3625427",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20231013/3625427/3625427_16971682952483_500.jpg"
          },
          {
            "id": 3535097,
            "rank": 2,
            "score": 0.6244687530156224,
            "product_name": "여성 사이드 플리츠 스커트 [네이비]",
            "brand": "라코스테",
            "brand_english": "LACOSTE",
            "product_url": "https://www.musinsa.com/app/goods/3535097",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20230906/3535097/3535097_17065056110434_500.jpg"
          },
          {
            "id": 3574303,
            "rank": 1,
            "score": 0.6245317779183388,
            "product_name": "SUNNY DYED SWEATPANTS_SKY",
            "brand": "샤이선",
            "brand_english": "SHYSON",
            "product_url": "https://www.musinsa.com/app/goods/3574303",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20230919/3574303/3574303_16951835824481_500.jpg"
          }
        ],
        "shoes": [
          {
            "id": 3880533,
            "rank": 5,
            "score": 0.6200253163259476,
            "product_name": "유니섹스 에런 트레일 슈즈 aaa356u(SILVER)",
            "brand": "앤더슨벨",
            "brand_english": "ANDERSSON BELL",
            "product_url": "https://www.musinsa.com/app/goods/3880533",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240219/3880533/3880533_17083292753668_500.jpg"
          },
          {
            "id": 3834027,
            "rank": 4,
            "score": 0.6211594336032866,
            "product_name": "웨버 스콧 (0093830) WV23101 WH",
            "brand": "슈마커",
            "brand_english": "SHOEMARKER",
            "product_url": "https://www.musinsa.com/app/goods/3834027",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240131/3834027/3834027_17066584516889_500.jpg"
          },
          {
            "id": 3880539,
            "rank": 3,
            "score": 0.62119376328215,
            "product_name": "유니섹스 에런 트레일 슈즈 aaa356u(BEIGE)",
            "brand": "앤더슨벨",
            "brand_english": "ANDERSSON BELL",
            "product_url": "https://www.musinsa.com/app/goods/3880539",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240219/3880539/3880539_17083292946573_500.jpg"
          },
          {
            "id": 3880535,
            "rank": 2,
            "score": 0.6227367207948119,
            "product_name": "유니섹스 에런 트레일 슈즈 aaa356u(RED)",
            "brand": "앤더슨벨",
            "brand_english": "ANDERSSON BELL",
            "product_url": "https://www.musinsa.com/app/goods/3880535",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20240219/3880535/3880535_17083292817709_500.jpg"
          },
          {
            "id": 3423708,
            "rank": 1,
            "score": 0.623048206448555,
            "product_name": "공용 로버-엘티 SPGMFNLS315UKHA",
            "brand": "스파이더",
            "brand_english": "SPYDER",
            "product_url": "https://www.musinsa.com/app/goods/3423708",
            "img_url":
                "https://image.msscdn.net/images/goods_img/20230725/3423708/3423708_16902443728853_500.jpg"
          }
        ]
      });
    }
  }

  static Future<void> postCloth(int clothId) async {
    try {
      await _dio.authDio.post(
        "/cloth/$clothId",
      );
    } catch (e) {
      print(e);
    }
  }
}
