import 'package:digitalhunt/Models/reel_model.dart';
import 'package:digitalhunt/Views/pages/reel_details.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:digitalhunt/widgets/cached_image.dart';
import 'package:flutter/material.dart';

class ReelCard extends StatelessWidget {
  final ReelModel? reelModel;
  const ReelCard({super.key, this.reelModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>nextScreen(context, ReelDetails(reelModel: reelModel,)),
      child: Container(height: 300, width: 250,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),),
        child: CustomCacheImage(imageUrl: Config().getYoutubeThumbnail(reelModel!.url), videoUrl: reelModel!.url, radius: 15),
      ),
    );
  }
}
