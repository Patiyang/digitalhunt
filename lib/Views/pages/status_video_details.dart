import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:digitalhunt/Models/post_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StatusVideoDetails extends StatefulWidget {
  final PostModel? postModel;
  const StatusVideoDetails({super.key, this.postModel});

  @override
  State<StatusVideoDetails> createState() => _StatusVideoDetailsState();
}

class _StatusVideoDetailsState extends State<StatusVideoDetails> {
  late YoutubePlayerController _controller;
  late VideoPlayerController _videoPlayerController;
  ChewieController? chewieController;
  bool loadingVideo = true;
  bool success = false;
  PostModel? postModel;
  @override
  void initState() {
    getArticleDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final innerScrollController = PrimaryScrollController.of(context);
    return Scaffold(
      appBar: AppBar( 
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).padding.top,),
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          postModel!.video_url.contains('youtube')
              ? YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    thumbnail: YoutubePlayer(controller: _controller).thumbnail,
                  ),
                  builder: (context, player) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: player);
                  },
                )
              : _videoPlayerController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: loadingVideo == true
                      ? CircularProgressIndicator()
                      : success == false
                      ? Text('unable to load video'.tr())
                      : Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Chewie(controller: chewieController!),
                        ),
                )
              : Container(),
        ],
      ),
    );
  }

  getArticleDetails() {
    postModel = widget.postModel;
    if (postModel!.video_url!.contains('youtube')) {
      initYoutube();
    } else {
      initOtherPlayer();
    }
  }

  initYoutube() async {
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(postModel!.video_url)!,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false, forceHD: false, loop: true, controlsVisibleAtStart: false, enableCaption: false),
    );

    Timer.periodic(Duration(seconds: 1), (t) {});
    _controller.addListener(() {});
    // _controller.value.isReady
    //     ? _controller.play()
    //     : _controller.addListener(() {
    //         if (_controller.value.isReady) {
    //           _controller.play();
    //         }
    //       });
    // _controller.play();
  }

  initOtherPlayer() async {
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(postModel!.video_url!));
    try {
      await _videoPlayerController.initialize();

      chewieController = ChewieController(videoPlayerController: _videoPlayerController, autoPlay: true, looping: true);
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
}
