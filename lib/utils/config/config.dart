import 'package:digitalhunt/Models/post_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  static const mainIp = testipAddress;
  static const avatarIp = publicTestIpAddress;
  static const mediaIp = testshareIp;
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

  String getYoutubeThumbnail(String videoUrl) {
    final Uri? uri = Uri.tryParse(videoUrl);
    if (uri == null) {
      return '';
    }

    return 'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg';
  }
}
