import 'package:digitalhunt/Models/theme_model.dart';
import 'package:digitalhunt/Services/dynamic_link_services.dart';
import 'package:digitalhunt/app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // AdmobHelper.initialize();
  await DynamicLinkService.instance.initialize();
    await MobileAds.instance.initialize();

  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.dark));
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  SharedPreferences prefs = await SharedPreferences.getInstance();

  UnityAds.init(
    gameId: '800358513',
    testMode: false,
    onComplete: () {
      UnityAds.load(
        placementId: 'Banner_Android',
        onComplete: (placementId) => print('Load Complete $placementId'),
        onFailed: (placementId, error, message) => print('Load Failed $placementId: $error $message'),
      );
      UnityAds.setPrivacyConsent(PrivacyConsentType.gdpr, true);
    },
    onFailed: (error, message) => print('Unity Ads Initialization Failed: $error $message'),
  );
  String getLanguages() {
    if (prefs.getString('language') == 'English') {
      ThemeModel().myValue = 'Poppins';
      return 'en';
    } else if (prefs.getString('language') == 'Kannada') {
      ThemeModel().myValue = 'Poppins';
      return 'kn';
    } else if (prefs.getString('language') == 'Hindi') {
      ThemeModel().myValue = 'Poppins';
      return 'hi';
    } else {
      prefs.setString('language', 'English');
      return 'en';
    }
  }

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('kn'), Locale('hi')],
      path: 'Assets/translations',
      fallbackLocale: Locale(getLanguages()),
      startLocale: Locale(getLanguages()),
      useOnlyLangCode: true,
      child: MyApp(),
    ),
  );
}
