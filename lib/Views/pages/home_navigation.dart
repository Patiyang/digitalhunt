import 'dart:async';
import 'dart:math' as math;

import 'package:digitalhunt/Blocs/bottomNavBar_bloc.dart';
import 'package:digitalhunt/Views/pages/news.dart';
import 'package:digitalhunt/Views/pages/profile.dart';
import 'package:digitalhunt/Views/pages/search.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/page_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final Uri? initialDeepLink;
  const HomePage({super.key, this.initialDeepLink});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  PageController _pageController = PageController(keepPage: true);
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<IconData> iconList = [
    Icons.list,
    Icons.search,
    Icons.remove_red_eye_outlined,
    Icons.refresh,
    // Icons.plus_circle
  ];
  bool _showBars = false;
  Timer? _barsTimer;
  StreamSubscription<Uri>? _linkSubscription;

  // ----------------------------------------------------------
  // SHOW / HIDE APP BAR + BOTTOM NAVIGATION
  // ----------------------------------------------------------

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

    return Scaffold(
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

          child: AppBar(title: const Text('Reader'), automaticallyImplyLeading: false, automaticallyImplyActions: false),
        ),
      ),

      // ======================================================
      // BODY
      // ======================================================
      body: SizedBox.expand(
        child: GestureDetector(behavior: HitTestBehavior.translucent, onTap: _toggleBars, child: News()),

        //   RefreshIndicator(
        //     onRefresh: _refresh,
        //     edgeOffset: Size.fromHeight(kToolbarHeight).height,
        //     child: ListView.builder(
        //       controller: _scrollController,

        //       physics: CustomPageScrollPhysics(pageHeight: MediaQuery.sizeOf(context).height, parent: const BouncingScrollPhysics()),

        //       itemCount: pages.length,

        //       itemBuilder: (context, index) {
        //         return FlipPage(
        //           controller: _scrollController,
        //           index: index,
        //           pageHeight: screenHeight,

        //           child: SizedBox(
        //             height: screenHeight,
        //             width: double.infinity,

        //             child: Container(
        //               color: Theme.of(context).shadowColor,

        //               alignment: Alignment.center,

        //               child: Text(pages[index], style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
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
      drawer: Drawer(child: _drawerWidget(), width: MediaQuery.of(context).size.width,),
      endDrawer: Drawer(child: _endDrawerWidget(), width: MediaQuery.of(context).size.width),
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
        BottomNavigationBarItem(icon: Icon(iconList[0]), label: 'settings'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[1], size: 25), label: 'search'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[2], size: 25), label: 'pending'.tr()),
        BottomNavigationBarItem(icon: Icon(iconList[3]), label: 'refresh'.tr()),
      ],
    );
  }

  void onTabTapped(int index) {
    // setState(() {
    //   context.read<BottomNavBloc>().currentIndex = index;
    // });
    // if (_pageController.hasClients) {
    //   _pageController.animateToPage(index, curve: Curves.easeIn, duration: Duration(milliseconds: 250));
    // }
    if (index == 0) {
      _scaffoldKey.currentState!.openDrawer();
    }
    if (index == 1) {
      _scaffoldKey.currentState!.openEndDrawer();
    }
    print(index);
  }

  Widget? _drawerWidget() {
    return ProfileSettings();
  }

  Widget? _endDrawerWidget() {
    return SearchFilter();
  }
}
