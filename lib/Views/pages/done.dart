import 'package:digitalhunt/Views/pages/intro.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class DonePage extends StatefulWidget {
  const DonePage({Key? key}) : super(key: key);

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 2000)).then((value) => nextScreenCloseOthers(context, IntroPage()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Lottie.asset(Config().doneAsset, alignment: Alignment.center, fit: BoxFit.cover, height: 200, width: 200, repeat: false),
      ),
    );
  }
}
