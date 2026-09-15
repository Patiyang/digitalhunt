import 'package:digitalhunt/Models/reel_model.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading_cards.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/home_category_card.dart';
import 'package:digitalhunt/widgets/profile_category_icon.dart';
import 'package:digitalhunt/widgets/reel_card.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryItem> categories = [
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 1'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 2'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 3'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 4'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 5'),
  ];

  List<ReelModel> reels = [];

  int listIndex = 0;
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: 5),

          Container(
            height: 350,
            child: PageView.builder(
              pageSnapping: false,
              padEnds: false,
              controller: PageController(initialPage: 0, viewportFraction: .5),
              scrollDirection: Axis.horizontal,
              itemCount: categories.isEmpty ? 3 : categories.length,
              onPageChanged: (index) {
                if (mounted) {
                  setState(() {
                    listIndex = index;
                  });
                }
              },
              itemBuilder: (BuildContext context, int index) {
                if (categories.isEmpty) return LoadingCard(height: 200, width: 100);
                return HomeCategoryCard(categoryItem: categories[index], index: index, total: categories.length);
              },
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: DotsIndicator(
              dotsCount: categories.isEmpty ? 3 : categories.length,
              position: listIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.black26,
                activeColor: Colors.black,
                spacing: EdgeInsets.only(left: 6),
                size: const Size.square(5.0),
                activeSize: const Size(20.0, 4.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: Divider(endIndent: 15, indent: 15)),
                CustomText(text: 'news_reels'.tr(), fontWeight: FontWeight.bold, size: 25),
                Expanded(child: Divider(endIndent: 15, indent: 15)),
              ],
            ),
          ),

          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.separated(
              addAutomaticKeepAlives: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: reels.isEmpty ? 3 : reels.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                return ReelCard(reelModel: reels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  void getData() {
    reels = [
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_71d42c68428f519d3285b1f08a681b2d.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_4b0eea0d021f59f6c062dcc8f9d5361a.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_00d2d8b58859dcafdfec33a1a8c5728c.mp4',
        image: Config().icon,
        description: '',
      ),
      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_f9e2e525a8cfc49e449a45d9726ac1c3.mp4',
        image: Config().icon,
        description: '',
      ),

      ReelModel(
        id: 0,
        title: 'reel 1',
        url: '${Config.mediaIp}uploads/media/202609/video_02a4c1ad585e04cc89862be755ac250b.mp4',
        image: Config().icon,
        description: '',
      ),
    ];
  }
}
