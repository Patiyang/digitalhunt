import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading_cards.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/home_category_card.dart';
import 'package:digitalhunt/widgets/profile_category_icon.dart';
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
  int listIndex = 0;
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
              pageSnapping: false,padEnds: false,
              controller: PageController(initialPage: 0,viewportFraction: .5),
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
          SizedBox(height: 15),

          Row(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Divider(endIndent: 15, indent: 15)),
              CustomText(text: 'news_reels'.tr(), fontWeight: FontWeight.bold, size:25 ,),
              Expanded(child: Divider(endIndent: 15, indent: 15)),
            ],
          ),
        ],
      ),
    );
  }
}
