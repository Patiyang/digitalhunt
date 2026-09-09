import 'package:flutter/material.dart';

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
    final Color amber = Colors.yellow;

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
}
