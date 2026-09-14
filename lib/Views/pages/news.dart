import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/native_banner_ads.dart';
import 'package:flutter/material.dart';
// import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> with AutomaticKeepAliveClientMixin {
  final List<String> pages = ['PAGE 1', 'PAGE 2', 'PAGE 3', 'PAGE 4', 'PAGE 5'];
  @override
  void initState() {
    super.initState();
    settings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: /* Center(
          child: Container(
            // height: 300,
            width: MediaQuery.of(context).size.width*2/3,
            color: Config().appColor,
            child: NativeBannerAd(
              onAdInfoPressed: () {
                print('pressed');
              },
            ),
          ),
        ), */
         PageView.builder(
              itemCount: pages.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: CustomText(text: pages[index], size: 24),
                );
              },
            )
      ),
    );
  }

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));

    // Fetch your latest articles here.
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  settings() {
    // UnityAds.setPrivacyConsent(PrivacyConsentType.ageGate, true);
  }
}
