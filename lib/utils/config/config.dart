import 'package:digitalhunt/Models/post_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_video_thumbnail/get_video_thumbnail.dart';
import 'package:get_video_thumbnail/index.dart';
import 'package:url_launcher/url_launcher.dart';

class Config {
  final String appName = 'Digitalhunt Media';
  final String splashIcon = 'Assets/images/splash.png';
  final String icon = 'Assets/images/icon.png';

  final String supportEmail = 'connect@onlinehunt.net';
  final String privacyPolicyUrl = 'https://thetechdefined.com/onlinehunt';
  final String ourWebsiteUrl = 'https://thetechdefined.com/onlinehunt';
  final String iOSAppId = '000000';

  //social links
  static const String facebookPageUrl = 'https://www.facebook.com/theonlinehunt';
  static const String youtubeChannelUrl = 'https://www.youtube.com/channel/UCnNr2eppWVVo-NpRIy1ra7A';
  static const String twitterUrl = 'https://twitter.com/FlutterDev';
  static const String emailSupport = 'onlinehuntnews@gmail.com';
  static const String phoneSupport = '+91 9008329745';

  //app theme color
  final Color appColor = Color(0XFF007BFD);
  final Color white = Colors.white;
  final Color amber = Colors.amber.shade300;

  //Intro images
  final String introImage1 = 'Assets/images/news2.png';
  final String introImage2 = 'Assets/images/news3.png';
  final String introImage3 = 'Assets/images/news4.png';
  final String noImage = 'Assets/images/noImage.png';
  //animation files
  final String doneAsset = 'Assets/animation_files/done.json';

  //Language Setup
  final List<String> languages = ['English', 'Kannada', 'Hindi'];

  //get the list of cities and districts
  static const String citiesAndDistricts = 'Assets/cities/cityList.json';

  //helper class

  static const baseUrl = "https://onlinehunt.in/api/";
  static const fileUpload = "https://onlinehunt.in/api/uploads/videos/";
  static const publicMainIpAddress = 'https://onlinehunt.in/';
  static const publicTestIpAddress = 'http://192.168.100.26/';

  static const testipAddress = 'http://${kIsWeb ? '127.0.0.1' : '192.168.100.26'}/api/';
  static const serverpAddress = 'https://onlinehunt.in/api/';
  static const liveshareIp = 'https://onlinehunt.in/';
  static const testshareIp = 'http://192.168.100.26/';

  static const mainIp = serverpAddress;
  static const avatarIp = publicMainIpAddress;
  static const mediaIp = liveshareIp;
  static const shareIp = liveshareIp;

  static const tokenKey = 'token';
  static const pdfItemBox = 'pdfItems';
  static const customAdItemBox = 'mobile_ads';

  getDate(DateTime? date, {bool? altDate}) {
    String _d = altDate == true ? DateFormat('dd MMM yyyy').format(date!) : DateFormat('dd/MM/yyyy').format(date!);
    return _d;
  } //12/06/2026

  getCategoryColor(String color) {
    return Color(int.parse(color.replaceFirst('#', '0xFF')));
  }

  String limitSummary(String? summary, {int maxWords = 15}) {
    if (summary == null || summary.trim().isEmpty) {
      return "Read the full story on Online Hunt.";
    }

    final words = summary.trim().split(RegExp(r'\s+'));

    if (words.length <= maxWords) {
      return summary.trim();
    }

    return '${words.take(maxWords).join(' ')}...';
  }

  String? extractYoutubeId(String url) {
    RegExp regExp = RegExp(
      r'^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/|shorts\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*',
      caseSensitive: false,
      multiLine: false,
    );

    final match = regExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }
    return null;
  }

  String getYoutubeThumbnail(String videoUrl) {
    final uri = Uri.tryParse(videoUrl.trim());

    if (uri == null) {
      return '';
    }

    String? videoId;

    // youtube.com/watch?v=VIDEO_ID
    if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];

      // youtube.com/shorts/VIDEO_ID
      if (videoId == null && uri.pathSegments.contains('shorts')) {
        final index = uri.pathSegments.indexOf('shorts');

        if (index + 1 < uri.pathSegments.length) {
          videoId = uri.pathSegments[index + 1];
        }
      }

      // youtube.com/embed/VIDEO_ID
      if (videoId == null && uri.pathSegments.contains('embed')) {
        final index = uri.pathSegments.indexOf('embed');

        if (index + 1 < uri.pathSegments.length) {
          videoId = uri.pathSegments[index + 1];
        }
      }

      // youtube.com/live/VIDEO_ID
      if (videoId == null && uri.pathSegments.contains('live')) {
        final index = uri.pathSegments.indexOf('live');

        if (index + 1 < uri.pathSegments.length) {
          videoId = uri.pathSegments[index + 1];
        }
      }
    }

    // youtu.be/VIDEO_ID
    if (videoId == null && uri.host == 'youtu.be') {
      if (uri.pathSegments.isNotEmpty) {
        videoId = uri.pathSegments.first;
      }
    }

    if (videoId == null || videoId.isEmpty) {
      return '';
    }

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  Future<Uint8List?> getVideoThumbnail(String videoUrl) async {
    try {
      return await VideoThumbnail.thumbnailData(video: videoUrl, imageFormat: ImageFormat.JPEG, maxWidth: 600, quality: 80);
    } catch (e) {
      print('Thumbnail error: $e');
      return null;
    }
  }

  double getYoutubeAspectRatio(String url) {
    final isShort = url.contains('/shorts/');

    return isShort ? 9 / 16 : 16 / 9;
  }

  Future<Uint8List?> getCachedThumbnail(String url,  Map<String, Uint8List> thumbnailCache) async {
    final cached = thumbnailCache[url];

    if (cached != null) {
      return cached;
    }

    final thumbnail = await getVideoThumbnail(url);

    if (thumbnail != null) {
      thumbnailCache[url] = thumbnail;
    }

    return thumbnail;
  }
  // Usage
  // String? id = extractYoutubeId("https://youtube.com");

  //share

  //   handleContentShare(BuildContext context, PostModel? postModel, {EpaperModel? epaperModel, LiveNews? liveNews}) async {
  //     SharePlus share = SharePlus.instance;
  //     String deepLink = generateDeepLink(context, postModel, epaperModel: epaperModel,liveNews: liveNews);

  //     await share.share(
  //       ShareParams(
  //         // uri: Uri.parse(deepLink),
  //         text:
  //             '''
  // 📰 ${postModel == null ? epaperModel == null
  //                   ? liveNews!.title
  //                   : 'By ${epaperModel.publication!.title} via Onlinehunt' : postModel.title}

  // ${HelperClass().limitSummary(postModel == null ? 'latest news'.tr() : postModel.summary)}

  // ${'click for more'.tr()}
  // $deepLink
  // ''',
  //         subject: postModel == null
  //             ? epaperModel == null
  //                   ? liveNews!.title
  //                   : '${epaperModel.title}'
  //             : postModel.title,
  //         title: postModel == null
  //             ? epaperModel == null
  //                   ? liveNews!.title
  //                   : epaperModel.title
  //             : postModel.title,
  //         // previewThumbnail: XFile(Config().splashIcon,),
  //       ),
  //     );
  //   }

  //   handleWhatsappShare(BuildContext context, PostModel? postModel) async {
  //     SharePlus share = SharePlus.instance;

  //     String deepLink = generateDeepLink(context, postModel!);

  //     final message =
  //         '''
  // 📰 ${postModel.title}

  // ${HelperClass().limitSummary(postModel.summary)}

  // ${'click for more'.tr()}
  // $deepLink
  // ''';
  //     final whatsappUrl = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(message)}");

  //     if (await canLaunchUrl(whatsappUrl)) {
  //       await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  //     } else {
  //       debugPrint('Could not launch WhatsApp');
  //     }
  //   }

  //   String generateDeepLink(BuildContext context, PostModel? postModel, {EpaperModel? epaperModel, LiveNews? liveNews}) {
  //     // return '${HelperClass.shareIp}$slug';
  //     if (postModel != null) {
  //       String type = postModel.video_url!.isNotEmpty ? 'video' : 'article';
  //       final languageCode = context.locale.languageCode;
  //       print('the code is $languageCode');
  //       if (languageCode == 'en') {
  //         return '${HelperClass.shareIp}${postModel.slug}?type=$type';
  //       }

  //       return '${HelperClass.shareIp}$languageCode/${postModel.slug}?type=$type';
  //     }

  //     if (epaperModel != null) {
  //       if (epaperModel.source_type == 'pdf') {
  //         return '${HelperClass.shareIp}paper?type=pdf&id=${epaperModel.id}&lang_id=${epaperModel.publication!.lang_id}';
  //       } else {
  //         return '${HelperClass.shareIp}paper?type=website&id=${epaperModel.id}&lang_id=${epaperModel.publication!.lang_id}';
  //       }
  //     } else {
  //       return '${HelperClass.shareIp}live?type=live_news&id=${liveNews!.liveNewsId}';
  //     }
  //   }
}
