import 'package:digitalhunt/Models/post_model.dart';
import 'package:digitalhunt/Views/pages/status_video_details.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:digitalhunt/widgets/cached_image.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StatusVideoCard extends StatelessWidget {
  final PostModel? postModel;
  const StatusVideoCard({super.key, this.postModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(postModel!.image_url);
        nextScreen(context, StatusVideoDetails(postModel: postModel,));
      },
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).shadowColor),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              child: CustomCacheImage(imageUrl: postModel!.image_url, videoUrl: postModel!.video_url, radius: 5),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  child: CustomText(text: 'category'.tr()),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Config().amber),
                ),
                SizedBox(height: 10),
                CustomText(text: postModel!.title),
                SizedBox(height: 20),
                CustomText(text: Config().getDate(DateTime.parse(postModel!.created_at))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
