import 'package:flutter/material.dart';
import 'package:ollive_front/models/cloth/cloth_model.dart';
import 'package:ollive_front/service/cloth/cloth_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClothWidget extends StatelessWidget {
  const ClothWidget({super.key, required this.clothModel});

  final ClothModel clothModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        ClothService.postCloth(clothModel.id);
        await launchUrlString(clothModel.url);
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              width: MediaQuery.of(context).size.width / 2.3,
              height: MediaQuery.of(context).size.width / 2.3,
              clothModel.imgUrl,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.3, // 이미지와 동일한 너비 설정

            child: Text(
              clothModel.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
