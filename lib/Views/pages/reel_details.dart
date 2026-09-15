import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:digitalhunt/Models/reel_model.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ReelDetails extends StatefulWidget {
  final ReelModel? reelModel;
  const ReelDetails({super.key, this.reelModel});

  @override
  State<ReelDetails> createState() => _ReelDetailsState();
}

class _ReelDetailsState extends State<ReelDetails> {
  late YoutubePlayerController _controller;
  late VideoPlayerController _videoPlayerController;
  late ChewieController chewieController;
  bool loadingVideo = true;
  bool success = false;
  ReelModel? reelModel;
  @override
  void dispose() {
    chewieController.dispose();
    _videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getReelDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: [
          Loading(),
          reelModel!.url.contains('youtube')
              ? YoutubePlayer(
                  controller: _controller,
                  aspectRatio: Config().getYoutubeAspectRatio(reelModel!.url),
                  builder: (context, player, controller) {
                    return Container(height: MediaQuery.of(context).size.height, child: player);
                  },
                )
              // YoutubePlayerBuilder(
              //     player: YoutubePlayer(
              //       controller: _controller,
              //       showVideoProgressIndicator: true,
              //       thumbnail: YoutubePlayer(controller: _controller).thumbnail,
              //     ),
              //     builder: (context, player) {
              //       return Container(
              //         height: MediaQuery.of(context).size.height,
              //         child: player);
              //     },
              //   )
              : _videoPlayerController.value.isInitialized
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: loadingVideo == true
                        ? Loading()
                        : success == false
                        ? Text('unable to load video'.tr())
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Chewie(controller: chewieController!),
                          ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  getReelDetails() {
    reelModel = widget.reelModel;
    if (reelModel!.url!.contains('youtube')) {
      initYoutube();
    } else {
      initOtherPlayer();
    }
  }

  initYoutube() async {
    // _controller = YoutubePlayerController(
    //   initialVideoId: YoutubePlayer.convertUrlToId(postModel!.video_url)!,
    //   flags: YoutubePlayerFlags(autoPlay: true, mute: false, forceHD: false, loop: true, controlsVisibleAtStart: false, enableCaption: false),
    // );
    _controller = YoutubePlayerController.fromVideoId(
      videoId: Config().extractYoutubeId(reelModel!.url)!,
      autoPlay: false,
      params: YoutubePlayerParams(loop: true, enableCaption: false, mute: false, showControls: true),
    );

    _controller.loadVideoById(videoId: Config().extractYoutubeId(reelModel!.url)!);
    Timer.periodic(Duration(seconds: 1), (t) {});
    // _controller.addListener(() {});
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
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(reelModel!.url));
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
