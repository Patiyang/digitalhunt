import 'package:digitalhunt/Models/post_model.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/status_video_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class StatusVideos extends StatefulWidget {
  const StatusVideos({super.key});

  @override
  State<StatusVideos> createState() => _StatusVideosState();
}

class _StatusVideosState extends State<StatusVideos> {
  List<PostModel> posts = [];
  @override
  void initState() {
    super.initState();
    getStatusVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: CustomText(text: 'status_video'.tr())),
      body: RefreshIndicator(
        onRefresh: () => getStatusVideos(),
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          itemCount: posts.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemBuilder: (BuildContext context, int index) {
            return StatusVideoCard(postModel: posts[index]);
          },
        ),
      ),
    );
  }

  getStatusVideos() {
    posts = [
      PostModel(id: 0, title: 'Status post 0', video_url: 'http://192.168.100.26/uploads/media/202609/video_2c1da8563c42ca86e8520e464a325970.mp4', image_url: '', created_at: DateTime.now().toString()),
      PostModel(id: 0, title: 'Status post 1', video_url: 'https://www.youtube.com/watch?v=Pt4n5gjgMJQ', image_url: "", created_at: DateTime.now().toString()),
      PostModel(id: 0, title: 'Status post 2', video_url: 'https://www.youtube.com/watch?v=hrSIaugpcdI', image_url: '', created_at: DateTime.now().toString()),
    ];
  }
}
