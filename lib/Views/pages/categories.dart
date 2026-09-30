import 'dart:convert';

import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/Models/category_model.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/loading_cards.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/fav_location_card.dart';
import 'package:digitalhunt/widgets/home_category_card.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<CategoryModel> categories = [];
  List<CategoryModel> favCategories = [];
  List localCategoryItems = [];
  List newsCategoryItems = [];

  List<String> states = [];
  List<dynamic> districts = [];
  String selectedState = '';
  String selectedDistricts = '';

  @override
  void initState() {
    getStates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(child: Divider(indent: 10, endIndent: 10)),
              CustomText(text: 'local_categories'.tr(), fontWeight: FontWeight.bold, size: 20),
              Expanded(child: Divider(indent: 10, endIndent: 10)),
            ],
          ),
          SizedBox(height: 15),
          Container(
            height: 300,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: localCategoryItems.isEmpty ? 3 : localCategoryItems.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                return localCategoryItems.isEmpty
                    ? LoadingCard(height: 300, width: 250)
                    : localCategoryItems[index].runtimeType == CategoryModel
                    ? HomeCategoryCard(width: 250, categoryItem: localCategoryItems[index], index: index, total: localCategoryItems.length)
                    : localCategoryItems[index];
              },
            ),
          ),
          SizedBox(height: 15),

          Row(
            children: [
              Expanded(child: Divider(indent: 10, endIndent: 10)),
              CustomText(text: 'news_categories'.tr(), fontWeight: FontWeight.bold, size: 20),
              Expanded(child: Divider(indent: 10, endIndent: 10)),
            ],
          ),
          SizedBox(height: 15),

          Container(
            height: 360,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: newsCategoryItems.isEmpty ? 3 : newsCategoryItems.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(width: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                return newsCategoryItems.isEmpty
                    ? LoadingCard(height: 360, width: 250)
                    : newsCategoryItems[index].runtimeType == CategoryModel
                    ? HomeCategoryCard(width: 250, categoryItem: newsCategoryItems[index], index: index, total: newsCategoryItems.length)
                    : SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  getCategories() {
    categories = [
      CategoryModel(categoryImage: Config().icon, categoryTitle: 'Category 1', district: 'Bagalkot'),
      CategoryModel(categoryImage: Config().icon, categoryTitle: 'Category 2', district: 'Shivamogga (Shimoga)'),
      CategoryModel(categoryImage: Config().icon, categoryTitle: 'Category 3', district: 'Bagalkot'),
      CategoryModel(categoryImage: Config().icon, categoryTitle: 'Category 4'),
      CategoryModel(categoryImage: Config().icon, categoryTitle: 'Category 5'),
    ];

    localCategoryItems = [categoryLocationWidget()];
    for (var element in categories) {
      if (element.district == selectedDistricts) {
        localCategoryItems.add(element);
      }
    }
    for (var element in categories) {
      newsCategoryItems.add(element);
    }
  }

  Widget categoryLocationWidget() {
    return Container(
      // height: 300,
      width: 300,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Theme.of(context).shadowColor),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(text: 'favorite_locations'.tr(), fontWeight: FontWeight.bold, size: 18),
          SizedBox(height: 10),
          // Column(mainAxisSize: MainAxisSize.min, children: districts.s,),

          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: districts.sublist(0, 6).length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                return FavLocationCard(district_name: districts[index]);
              },
            ),
          ),

          SizedBox(height: 10),

          ClipRRect(
            child: DottedBorder(
              options: RoundedRectDottedBorderOptions(radius: Radius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Theme.of(context).primaryColor),
                    CustomText(text: 'add_location'.tr(), color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, size: 18),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  getStates() async {
    final sb = context.read<SignInBloc>();
    // bioCtrl.text = sb.userModel.about_me!;
    String data = await DefaultAssetBundle.of(context).loadString(Config.citiesAndDistricts);
    final jsonResult = jsonDecode(data);
    // print(jsonResult);
    for (int i = 0; i < jsonResult['states'].length; i++) {
      states.add(jsonResult['states'][i]['state']);
    }
    // Fluttertoast.showToast(msg: 'Already present $state!');
    selectedState = 'Karnataka';

    if (selectedState.isNotEmpty) {
      getDistricts();
    } else {
      setState(() {});
    }
  }

  getDistricts() async {
    final sb = context.read<SignInBloc>();

    districts = [];
    String data = await DefaultAssetBundle.of(context).loadString(Config.citiesAndDistricts);
    final jsonResult = jsonDecode(data);
    // print(jsonResult['states'][0]);
    districts = jsonResult['states'][states.indexOf(selectedState)]['districts'];
    selectedDistricts = sb.district ?? districts[0];
    getCategories();
    setState(() {});
    print(districts);
  }
}
