import 'package:digitalhunt/Blocs/sign_in_bloc.dart';
import 'package:digitalhunt/Views/pages/settings.dart';
import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/utils/next_screen.dart';
import 'package:digitalhunt/widgets/custom_profile_list_tile.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/profile_category_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';
import 'package:provider/provider.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => ProfileSettingsState();
}

class ProfileSettingsState extends State<ProfileSettings> {
  List<CategoryItem> categoryItems = [
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 1'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 2'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 3'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 4'),
    CategoryItem(categoryImage: Config().icon, categoryTitle: 'Category 5'),
  ];
  List<CustomProfileListTile> listItems = [];
  @override
  void initState() {
    super.initState();
    getListItems();
  }

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: MediaQuery.of(context).size.width * .6,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                nextScreen(context, Settings());
              },
              icon: FaIcon(FontAwesomeIcons.gears, size: 14),
            ),
            IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.magnifyingGlass, size: 14)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: ()=>Navigator.pop(context),
            child: CustomText(text: 'exit'.tr())),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          shrinkWrap: true,
          children: [
            userUi(context),
            ListTile(
              leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.globe, size: 14)),
              title: CustomText(text: 'select language'.tr(), size: 18, fontWeight: FontWeight.w700),
              subtitle: CustomRich(boldFont: 'select language'.tr(), lightFont: 'english'.tr()),
              trailing: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_forward),
              ),
            ),
            ListTile(
              leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.locationPin, size: 14)),
              title: CustomText(text: 'select region'.tr(), size: 18, fontWeight: FontWeight.w700),
              subtitle: CustomRich(boldFont: 'add location'.tr(), lightFont: 'change'.tr(), reversed: false),
              trailing: Container(
                decoration: BoxDecoration(shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.arrow_forward),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: CustomText(text: 'categories'.tr()),
            ),
            Container(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: categoryItems.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 20);
                },
                itemBuilder: (BuildContext context, int index) {
                  return ProfileCategory(categoryItem: categoryItems[index]);
                },
              ),
            ),

            ListView.separated(
              itemCount: listItems.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return ProfileListTile(customProfileListTile: listItems[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  userUi(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    if (sb.guestUser) {
      return ListTile(
        leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.person)),
        title: CustomText(text: 'guest'.tr(), size: 18, fontWeight: FontWeight.w700),
        subtitle: CustomRich(lightFont: 'to select email id'.tr(), boldFont: 'click here'.tr(), callback: () {}),
      );
    }
    return userSignedInUi();
  }

  userSignedInUi() {}

  void getListItems() async{
        // await Future.delayed(Duration(microseconds: 5));

    listItems = [
      CustomProfileListTile(
        leadingImage: Icon(Icons.eco),
        title: 'fact_check'.tr(),
        trailing: CustomRich(boldFont: 'check_now'.tr()),
        callback: () {
          print('fact check');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.contact_page),
        title: 'ref'.tr(),
        trailing: CustomRich(boldFont: 'refer_now'.tr()),
        callback: () {
          print('ref');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.video_camera_back),
        title: 'status_video'.tr(),
        callback: () {
          print('status_video');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.document_scanner),
        title: 'exclusive'.tr(),
        callback: () {
          print('exclusive');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.settings),
        title: 'settings'.tr(),
        callback: () {
          print('settings');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.star),
        title: 'response'.tr(),
        callback: () {
          print('response');
        },
      ),
      CustomProfileListTile(
        leadingImage: Icon(Icons.mail),
        title: 'contact'.tr(),
        callback: () {
          print('contact');
        },
      ),
    ];
  }
}
