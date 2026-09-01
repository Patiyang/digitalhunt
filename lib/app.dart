import 'package:digitalhunt/Blocs/bottomNavBar_bloc.dart';
import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/Blocs/theme_bloc.dart';
import 'package:digitalhunt/Models/theme_model.dart';
import 'package:digitalhunt/Views/pages/splash.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;
final FirebaseAnalyticsObserver firebaseObserver = FirebaseAnalyticsObserver(analytics: firebaseAnalytics);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeBloc>(
      create: (_) => ThemeBloc(),
      child: Consumer<ThemeBloc>(
        builder: (_, mode, child) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<SignInBloc>(create: (context) => SignInBloc()),
              // ChangeNotifierProvider<CommentsBloc>(create: (context) => CommentsBloc()),
              // ChangeNotifierProvider<BookmarkBloc>(create: (context) => BookmarkBloc()),
              // ChangeNotifierProvider<SearchBloc>(create: (context) => SearchBloc()),
              // ChangeNotifierProvider<FeaturedBloc>(create: (context) => FeaturedBloc()),
              // ChangeNotifierProvider<PopularBloc>(create: (context) => PopularBloc()),
              // ChangeNotifierProvider<RecentBloc>(create: (context) => RecentBloc()),
              // // ChangeNotifierProvider<AllUserArticlesBloc>(create: (context) => AllUserArticlesBloc()),
              // ChangeNotifierProvider<CategoriesBloc>(create: (context) => CategoriesBloc()),
              // ChangeNotifierProvider<LiveNewsBloc>(create: (context) => LiveNewsBloc()),
              // ChangeNotifierProvider<SingleEpaperBloc>(create: (context) => SingleEpaperBloc()),
              // ChangeNotifierProvider<MagazineBloc>(create: (context) => MagazineBloc()),
              // ChangeNotifierProvider<FavoriteMagazineBloc>(create: (context) => FavoriteMagazineBloc()),

              // ChangeNotifierProvider<AdsBloc>(create: (context) => AdsBloc()),

              // ChangeNotifierProvider<DailyPeriodicalBloc>(create: (context) => DailyPeriodicalBloc()),
              // ChangeNotifierProvider<WeeklyPeriodicalBloc>(create: (context) => WeeklyPeriodicalBloc()),
              // ChangeNotifierProvider<FortnightlyPeriodicalBloc>(create: (context) => FortnightlyPeriodicalBloc()),
              // ChangeNotifierProvider<MonthlyPeriodicalBloc>(create: (context) => MonthlyPeriodicalBloc()),

              //  ChangeNotifierProvider<DailyPDFPeriodicalBloc>(create: (context) => DailyPDFPeriodicalBloc()),
              // ChangeNotifierProvider<WeeklyPDFPeriodicalBloc>(create: (context) => WeeklyPDFPeriodicalBloc()),
              // ChangeNotifierProvider<FortnightlyPDFPeriodicalBloc>(create: (context) => FortnightlyPDFPeriodicalBloc()),
              // ChangeNotifierProvider<MonthlyPDFPeriodicalBloc>(create: (context) => MonthlyPDFPeriodicalBloc()),

              // ChangeNotifierProvider<FeaturedEpapersBloc>(create: (context) => FeaturedEpapersBloc()),
              // ChangeNotifierProvider<MagazineCategoriesBloc>(create: (context) => MagazineCategoriesBloc()),

              // // ChangeNotifierProvider<RelatedBloc>(create: (context) => RelatedBloc()),
              // ChangeNotifierProvider<TabIndexBloc>(create: (context) => TabIndexBloc()),
              // ChangeNotifierProvider<VideoTabIndexBloc>(create: (context) => VideoTabIndexBloc()),
              ChangeNotifierProvider<BottomNavBloc>(create: (context) => BottomNavBloc()),
              // ChangeNotifierProvider<NotificationBloc>(create: (context) => NotificationBloc()),
              // ChangeNotifierProvider<CustomNotificationBloc>(create: (context) => CustomNotificationBloc()),
              // ChangeNotifierProvider<ArticleNotificationBloc>(create: (context) => ArticleNotificationBloc()),
              // ChangeNotifierProvider<VideosBloc>(create: (context) => VideosBloc()),
            ],
            child: MaterialApp(
              supportedLocales: context.supportedLocales,
              localizationsDelegates: context.localizationDelegates,
              locale: context.locale,
              navigatorObservers: [firebaseObserver], 
              theme: ThemeModel().lightMode,
              darkTheme: ThemeModel().darkMode,
              themeMode: mode.darkTheme == true ? ThemeMode.dark : ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: AppHome(),
            ),
          );
        },
      ),
    );
  }
}

class AppHome extends StatefulWidget with WidgetsBindingObserver {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  final key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Center(
        child: Loading(spinkit: SpinKitCubeGrid(color: Theme.of(context).primaryColor),text: 'gathering_info'.tr(),),
      ),
    );
  }

  screenCheck() {
    Future.delayed(Duration(milliseconds: 2000)).whenComplete(() => nextScreen(context, SplashPage()));
  }

  getLanguage() async {
    // await _noScreenshot.screenshotOff();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getString('language') == null) {
      getLanguageBottomSheet();
    } else {
      screenCheck();
      // checkLink();
    }
  }

  getLanguageBottomSheet() {
    showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9)),
      ),
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 5),

                Text(
                  'select language cont'.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  itemCount: Config().languages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _itemList(Config().languages[index], index, context);
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _itemList(d, index, BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.language),
          title: Text(d.toString().toLowerCase().tr()),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (d == 'English') {
              context.setLocale(Locale('en'));
              prefs.setString('language', 'English');
              prefs.setInt('lang_id', 1);
              ThemeModel().myValue = 'Manrope';
            } else if (d == 'Kannada') {
              context.setLocale(Locale('kn'));
              prefs.setString('language', 'Kannada');
              prefs.setInt('lang_id', 4);
              ThemeModel().myValue = 'NotoSerif';
            } else if (d == 'Hindi') {
              context.setLocale(Locale('hi'));
              prefs.setString('language', 'Hindi');
              prefs.setInt('lang_id', 3);
              ThemeModel().myValue = 'Karma';
            }
            // var value = await refresh(context);
            // if (value == true) {
            //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => MyHome()), (route) => true);
            // }
            nextScreenCloseOthers(context, this);
            // await getCategories();
          },
        ),
        Divider(height: 3, color: Colors.grey[400]),
      ],
    );
  }
}
