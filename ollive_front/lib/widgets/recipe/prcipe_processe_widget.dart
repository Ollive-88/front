import 'package:flutter/widgets.dart';
import 'package:ollive_front/models/recipe/recipe_detail_model.dart';
import 'package:ollive_front/widgets/recipe/recipe_thumbnail_widget.dart';

// ignore: must_be_immutable
class RecipeProcesses extends StatelessWidget {
  RecipeProcesses({super.key, required this.processeModel});

  ProcesseModel processeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${processeModel.cookOrder}. ",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Flexible(
              child: Text(
                processeModel.content,
                maxLines: 10,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        RecipeThumbnail(
          thumbnailUrl: processeModel.imageUrl,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
