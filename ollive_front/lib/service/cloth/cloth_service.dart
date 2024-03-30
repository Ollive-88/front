import 'package:ollive_front/models/cloth/cloth_list_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class ClothService {
  static final DioService _dio = DioService();

  static Future<ClothListModel> getRecommendClothList(
      String outing, String sing) async {
    try {
      final response = await _dio.authDio.get(
        "/cloth/recommendation",
        data: {
          "outing": outing,
          "sing": sing,
        },
      );

      ClothListModel clothList = ClothListModel.fromJson(response.data);

      return clothList;
    } catch (e) {
      return ClothListModel.fromJson({
        "outerList": [
          {
            "name": "백 사틴 초어 재킷 [네이비]",
            'category': "아웃터",
            "url": "https://www.musinsa.com/app/goods/3790843?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20240112/3790843/3790843_17073772535046_500.jpg",
          },
          {
            "name": "오버 다잉 페이디드 워크 자켓 (워시드블랙)",
            'category': "아웃터",
            "url": "https://www.musinsa.com/app/goods/3851969?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20240206/3851969/3851969_17073745128669_500.jpg",
          },
          {
            "name": "릴렉스드 베이식 블레이저 [블랙]",
            'category': "아웃터",
            "url": "https://www.musinsa.com/app/goods/1558197?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20200820/1558197/1558197_16760173335705_500.jpg",
          },
        ],
        'topList': [
          {
            "name": "빅 트위치 로고 티셔츠 화이트",
            'category': "상의",
            "url": "https://www.musinsa.com/app/goods/3932869?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20240308/3932869/3932869_17098639041584_500.jpg",
          },
          {
            "name": "레이어드 크루 넥 반팔 티셔츠_일반 기장 [화이트]",
            'category': "상의",
            "url": "https://www.musinsa.com/app/goods/2086653?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20210825/2086653/2086653_17048764754484_500.jpg",
          },
          {
            "name": "RV_OUR 1989 후드 (STHSTD-0004)",
            'category': "상의",
            "url": "https://www.musinsa.com/app/goods/2990516?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20221220/2990516/2990516_16947563515196_500.jpg",
          },
        ],
        "bottomList": [
          {
            "name": "cotton fatigue pants regular fit beige",
            'category': "하의",
            "url": "https://www.musinsa.com/app/goods/241111?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20150826/241111/241111_4_500.jpg",
          },
          {
            "name": "Deep One Tuck Sweat Pants [Grey]",
            'category': "하의",
            "url": "https://www.musinsa.com/app/goods/1551840?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20200818/1551840/1551840_1_500.jpg",
          },
          {
            "name": "세미 와이드 히든 밴딩 슬랙스 [블랙]",
            'category': "하의",
            "url": "https://www.musinsa.com/app/goods/1149329?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20190910/1149329/1149329_16760172077751_500.jpg",
          },
        ],
        "shoesList": [
          {
            "name": "아디폼 슈퍼스타 부츠 - 블랙 / IG3029",
            'category': "신발",
            "url": "https://www.musinsa.com/app/goods/3397113?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20230706/3397113/3397113_16886259151241_500.jpg",
          },
          {
            "name":
                "[2-pack] zero 더비슈즈 01 + zero 더비슈즈 02 + ZERO 첼시부츠 + 5in zero 독일군",
            'category': "신발",
            "url": "https://www.musinsa.com/app/goods/3491717?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20230823/3491717/3491717_17108354458197_500.jpg",
          },
          {
            "name": "OFFICE - 111(a)",
            'category': "신발",
            "url": "https://www.musinsa.com/app/goods/2735953?loc=goods_rank",
            'imgUrl':
                "https://image.msscdn.net/images/goods_img/20220823/2735953/2735953_17073728692605_500.jpg",
          },
        ]
      });
    }
  }
}
