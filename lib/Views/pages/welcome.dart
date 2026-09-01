import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/Services/app_service.dart';
import 'package:digitalhunt/Views/pages/done.dart';
import 'package:digitalhunt/utils/app_name.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:digitalhunt/utils/snacbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
    var scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController _googleController = new RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
       return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: [
          /* widget.tag != null
              ? Container()
              :  */TextButton(
                  onPressed: () => handleSkip(),
                  child: Text('skip', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)).tr(),
                ),
          // IconButton(
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.all(0),
          //   iconSize: 22,
          //   icon: Icon(Icons.language),
          //   onPressed: () {
          //     nextScreenPopup(context, LanguagePopup());
          //   },
          // ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(image: AssetImage(Config().splashIcon), height: 130),
                  SizedBox(height: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'welcome to',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300, color: Theme.of(context).secondaryHeaderColor),
                          ).tr(),
                          SizedBox(width: 10),
                          AppName(fontSize: 25),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30, top: 5),
                        child: Text(
                          'sign in to continue',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Theme.of(context).secondaryHeaderColor),
                        ).tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedLoadingButton(
                    controller: _googleController,
                    onPressed: () => handleGoogleSignIn(),
                    width: MediaQuery.of(context).size.width * 0.80,
                    color: Colors.blueAccent,
                    elevation: 0,
                    child: Wrap(
                      children: [
                        FaIcon(FontAwesomeIcons.google, size: 25, color: Colors.white),
                        SizedBox(width: 15),
                        Text(
                          'google sign in'.tr(),
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                        ),
                      ],
                    ),
                    //borderRadius: 3,
                  ),
                  SizedBox(height: 10),
                  // RoundedLoadingButton(
                  //   controller: _facebookController,
                  //   onPressed: () => handleFacebbokLogin(),
                  //   width: MediaQuery.of(context).size.width * 0.80,
                  //   color: Colors.indigo,
                  //   elevation: 0,
                  //   child: Wrap(
                  //     children: [
                  //       FaIcon(FontAwesomeIcons.facebook, size: 25, color: Colors.white),
                  //       SizedBox(width: 15),
                  //       Text(
                  //         'facebook sign in'.tr(),
                  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  //   //borderRadius: 3,
                  // ),
                  SizedBox(height: 10),
                  // Platform.isAndroid ? Container() : _appleSignInButton(),
                ],
              ),
            ),
            Text("don't have social accounts?").tr(),
            TextButton(
              child: Text('continue with email >>', style: TextStyle(color: Theme.of(context).primaryColor)).tr(),
              onPressed: () {
                // if (widget.tag == null) {
                //   nextScreen(context, SignUpPage());
                // } else {
                //   nextScreen(context, SignUpPage(tag: 'Popup'));
                // }
              },
            ),
            SizedBox(height: 65),
          ],
        ),
      ),
    );
  }

    handleSkip() {
    final sb = context.read<SignInBloc>();
    sb.setGuestUser();
    nextScreen(context, DonePage());
  }

    handleAfterSignIn() {
    setState(() {
      Future.delayed(Duration(milliseconds: 1000)).then((f) {
      nextScreen(context, DonePage());
      });
    });
  }
   handleGoogleSignIn() async {
    final SignInBloc sb = Provider.of<SignInBloc>(context, listen: false);
    await AppService().checkInternet().then((hasInternet) async {
      if (hasInternet == false) {
        openSnacbar(scaffoldKey, 'check your internet connection!'.tr());
      } else {
        // await sb.signInWithGoogle().then((_) {
        //   if (sb.hasError == true) {
        //     openSnacbar(scaffoldKey, 'something is wrong. please try again.'.tr());
        //     _googleController.reset();
        //   } else {
        //     sb.checkApiUserExists().then((value) {
        //       if (value == true) {
        //         sb
        //             .getProfile()
        //             .then((value) => sb.guestSignout())
        //             .then(
        //               (value) => sb.saveDataToSP().then(
        //                 (value) => sb.setSignIn().then((value) {
        //                   _googleController.success();
        //                   handleAfterSignIn();
        //                 }),
        //               ),
        //             );
        //       } else {
        //         sb
        //             .getTimestamp()
        //             .then(
        //               (value) => sb.saveToFirebase().then((value) {
        //                 if (value == true) {
        //                   sb.guestSignout().then(
        //                     (value) => sb.saveDataToSP().then(
        //                       (value) => sb.setSignIn().then((value) {
        //                         _googleController.success();
        //                         handleAfterSignIn();
        //                       }),
        //                     ),
        //                   );
        //                 } else {
        //                   openSnacbar(scaffoldKey, 'something is wrong. please try again.'.tr());
        //                   _googleController.reset();
        //                 }
        //               }),
        //             )
        //             .onError((error, stackTrace) {
        //               print(error.toString());
        //               // openSnacbar(scaffoldKey, 'something is wrong. please try again.'.tr());
        //               _googleController.reset();
        //             });
        //         // .then((value) => sb.increaseUserCount())
        //         // .then((value) =>
        //       }
        //     });
        //   }
        // });
      }
    });
  }

}