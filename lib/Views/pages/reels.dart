import 'package:chewie/chewie.dart';
import 'package:digitalhunt/Models/reel_model.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading.dart';
import 'package:digitalhunt/utils/loading_cards.dart';
import 'package:digitalhunt/widgets/cached_image.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Reels extends StatefulWidget {
  const Reels({super.key});

  @override
  State<Reels> createState() => _ReelsState();
}

class _ReelsState extends State<Reels> with AutomaticKeepAliveClientMixin {
  List<ReelModel> reels = [];
  int listIndex = 0;
  late YoutubePlayerController _controller;
  late VideoPlayerController _videoPlayerController;
  late ChewieController chewieController;
  bool loadingVideo = true;
  bool success = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    _videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - (kBottomNavigationBarHeight + 30),

          child: PageView.builder(
            pageSnapping: true,
            padEnds: true,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemCount: reels.isEmpty ? 3 : reels.length,
            onPageChanged: (index) {
              chewieController.pause();
              if (mounted) {
                listIndex = index;
                loadVideo(reels[index]);
                // setState(() {
                // });
              }
            },
            itemBuilder: (BuildContext context, int index) {
              if (reels.isEmpty) return LoadingCard(height: 200, width: 100);
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: loadingVideo == true
                      ? Loading()
                      : success == false
                      ? Text('unable to load video'.tr())
                      : Container(
                          // height:double.infinity - kBottomNavigationBarHeight,
                          width: MediaQuery.of(context).size.width,
                          child: listIndex == index
                              ? Chewie(controller: chewieController!)
                              : CustomCacheImage(imageUrl: Config().getYoutubeThumbnail(reels[index].url), videoUrl: reels[index].url, radius: 0),
                        ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  getData() {
    reels = [
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_71d42c68428f519d3285b1f08a681b2d.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_4b0eea0d021f59f6c062dcc8f9d5361a.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_00d2d8b58859dcafdfec33a1a8c5728c.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_f9e2e525a8cfc49e449a45d9726ac1c3.mp4',
        image: Config().icon,
        description: '',
      ),

      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_02a4c1ad585e04cc89862be755ac250b.mp4',
        image: Config().icon,
        description: '',
      ),
    ];
    loadVideo(reels[0]);
  }

  loadVideo(ReelModel reelModel) async {
    setState(() {
      success = false;
      loadingVideo = true;
    });
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(reelModel!.url!));
    try {
      await _videoPlayerController.initialize();

      chewieController = ChewieController(videoPlayerController: _videoPlayerController, autoPlay: true, looping: true, showControls: true);
      setState(() {
        success = true;
        loadingVideo = false;
      });
    } catch (e) {
      print(e.toString());
    }

    // _videoPlayerController.initialize();
    // _videoPlayerController.play();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
