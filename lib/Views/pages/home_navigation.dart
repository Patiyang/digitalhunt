import 'dart:async';
import 'dart:math' as math;

import 'package:digitalhunt/Blocs/bottomNavBar_bloc.dart';
import 'package:digitalhunt/Views/pages/categories.dart';
import 'package:digitalhunt/Views/pages/home.dart';
import 'package:digitalhunt/Views/pages/local_news.dart';
import 'package:digitalhunt/Views/pages/news.dart';
import 'package:digitalhunt/Views/pages/profile.dart';
import 'package:digitalhunt/Views/pages/reels.dart';
import 'package:digitalhunt/Views/pages/search.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/page_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeNav extends StatefulWidget {
  final Uri? initialDeepLink;
  const HomeNav({super.key, this.initialDeepLink});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(keepPage: true);
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  List<IconData> iconList = [
    Icons.home,
    Icons.newspaper,
    Icons.category_outlined,
    Icons.video_file_outlined,
    Icons.location_pin,

    // Icons.plus_circle
  ];
  bool _showBars = true;
  Timer? _barsTimer;
  StreamSubscription<Uri>? _linkSubscription;

  // ----------------------------------------------------------
  // SHOW / HIDE APP BAR + BOTTOM NAVIGATION
  // ----------------------------------------------------------

  // ----------------------------------------------------------
  // REFRESH
  // ----------------------------------------------------------

  // ----------------------------------------------------------
  // DISPOSE
  // ----------------------------------------------------------

  @override
  void dispose() {
    _barsTimer?.cancel();
    _scrollController.dispose();
    _pageController.dispose();
    _linkSubscription?.cancel();
    super.dispose();
  }

  // ----------------------------------------------------------
  // BUILD
  // ----------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final bb = context.watch<BottomNavBloc>();
    return PopScope(
      onPopInvokedWithResult: (val, res) {
        _onWillPop();
      },
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        key: _scaffoldKey,
        // ======================================================
        // APP BAR
        // ======================================================
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AnimatedSlide(
            offset: _showBars ? Offset.zero : const Offset(0, -1),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,

            child: AppBar(
              title: bb.currentIndex == 0 || bb.currentIndex == 2 ? Text('Digitalhunt News') : Icon(iconList[bb.currentIndex]),
              automaticallyImplyLeading: false,
              automaticallyImplyActions: false,
              centerTitle: true,
              leading: IconButton(onPressed: () => _scaffoldKey.currentState!.openDrawer(), icon: FaIcon(FontAwesomeIcons.circleUser)),
              actions: [IconButton(onPressed: () => _scaffoldKey.currentState!.openDrawer(), icon: FaIcon(FontAwesomeIcons.circlePlus))],
            ),
          ),
        ),

        // ======================================================
        // BODY
        // ======================================================
        body: PageView(
          controller: _pageController,
          allowImplicitScrolling: false,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            // SizedBox.expand(
            //   child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: _toggleBars, child: News()),
            // ),
            HomePage(),
            SizedBox.expand(
              child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: _toggleBars, child: News()),
            ),
            Categories(),
            Reels(),
            LocalNews(),
          ],
        ),

        // ======================================================
        // BOTTOM NAVIGATION
        // ======================================================
        bottomNavigationBar: AnimatedSlide(
          offset: _showBars ? Offset.zero : const Offset(0, 1),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          child: ChangeNotifierProvider(create: (context) => BottomNavBloc(), child: _bottomNavigationBar()),
        ),
        drawerEnableOpenDragGesture: false,
        endDrawerEnableOpenDragGesture: false,
        drawer: Drawer(child: _drawerWidget(), width: MediaQuery.of(context).size.width),
        endDrawer: Drawer(child: _endDrawerWidget(), width: MediaQuery.of(context).size.width),
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    print(context.locale.toString());

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) => onTabTapped(index),
      currentIndex: context.read<BottomNavBloc>().currentIndex,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      iconSize: 25,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(iconList[0]), label: 'home'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[1]), label: 'news'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[2]), label: 'categories'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[3]), label: 'reels'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[4]), label: 'local_news'.tr()),
      ],
    );
  }

  void onTabTapped(int index) {
    setState(() {
      context.read<BottomNavBloc>().currentIndex = index;
    });
    if (_pageController.hasClients) {
      _pageController.animateToPage(index, curve: Curves.easeIn, duration: Duration(milliseconds: 250));
    }
    if (index != 1) {
      _barsTimer!.cancel();
      _showBars = true;

      setState(() {});
    }
    // if (index == 0) {
    //   _scaffoldKey.currentState!.openDrawer();
    // }
    // if (index == 1) {
    //   _scaffoldKey.currentState!.openEndDrawer();
    // }
    print(index);
  }

  void _toggleBars() {
    _barsTimer?.cancel();

    setState(() {
      _showBars = !_showBars;
    });

    // Automatically hide again after 3 seconds
    if (_showBars) {
      _barsTimer = Timer(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _showBars = false;
          });
        }
      });
    }
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeIn);
    } else {
      await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop', true);
    }
  }

  Widget? _drawerWidget() {
    return ProfileSettings();
  }

  Widget? _endDrawerWidget() {
    return SearchFilter();
  }
}
