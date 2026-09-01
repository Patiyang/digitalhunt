import 'dart:async';

import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/Services/dynamic_link_services.dart';
import 'package:digitalhunt/widgets/page_item.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'home_navigation.dart';
import 'welcome.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final uri = DynamicLinkService.instance.pendingUri;

    final List<String> pages = ['PAGE 1', 'PAGE 2', 'PAGE 3', 'PAGE 4', 'PAGE 5'];

  @override
  void initState() {
    // checkLink();
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(Config().splashIcon, height: 120, width: 120, fit: BoxFit.contain),
        // child: Image(image: AssetImage(Config().splashIcon), height: 120, width: 120, fit: BoxFit.contain),
      ),
    );
  }

  afterSplash() {
    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      sb.isSignedIn == true || sb.guestUser == true ? gotoHomePage() : gotoSignInPage();
    });
  }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    nextScreenReplace(context, HomePage(initialDeepLink: uri,));
    // nextScreen(context, Way2NewsPageView(itemCount: pages.length, itemBuilder: (context, index) {
    //     final article = pages[index];

    //     return Text( '${article[index]}');
    //   }, onRefresh:()=> _refresh()));

  }
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));

    // Fetch your latest articles here.
  }
  gotoSignInPage() {
    nextScreenReplace(context, WelcomePage());
  }
}
