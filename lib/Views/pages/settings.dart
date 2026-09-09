import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/widgets/contact_us_items.dart';
import 'package:digitalhunt/widgets/custom_settings_toggle.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Blocs/sign_in_bloc.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with WidgetsBindingObserver {
  bool parentalControl = false;
  List<ContactItem> tileItems = [];
  List<SettingsToggleItem> settingsToggles = [];
  @override
  void initState() {
    super.initState();
    getToggles();
  }

  @override
  Widget build(BuildContext context) {
    // List<SettingsToggleItem>
    final sb = context.watch<SignInBloc>();
    return Scaffold(
      appBar: AppBar(elevation: 0, automaticallyImplyLeading: true),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        children: [          SizedBox(height: 20),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: 'settings'.tr(), fontWeight: FontWeight.bold, size: 30),
              Text('Version: ${sb.appVersion}', style: TextStyle(fontSize: 13)),
            ],
          ),          SizedBox(height: 20),

          Divider(color: Theme.of(context).shadowColor),
                    SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(color: Config().amber.withAlpha(150), borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Icon(Icons.notifications),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomRich(
                      boldFont: 'click_here',
                      lightFont: 'missing_notifications'.tr(),
                      reversed: true,
                      callback: () {
                        print('handle notification');
                      },
                    ),
                    CustomText(text: 'missing_notification_details'.tr()),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            child: Center(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: settingsToggles.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(width: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return NotificationToggle(settingsToggleItem: settingsToggles[index]);
                },
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Icon(Icons.person),
                SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(text: 'parental_ctrl'.tr()),
                    CustomText(text: 'parental_ctrl_desc'.tr()),
                  ],
                ),
                Spacer(),
                Switch(
                  value: parentalControl,
                  onChanged: (val) {
                    toggleParental(val);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 20),

          CustomText(text: 'contact_us'.tr(), fontWeight: FontWeight.bold, size: 27),
          SizedBox(height: 20),

          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: tileItems.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(height: 10);
            },
            itemBuilder: (BuildContext context, int index) {
              return ContactUsTile(contactItem: tileItems[index]);
            },
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: settingsToggles.map((el) => NotificationToggle(settingsToggleItem: el)).toList(),
          // ),
        ],
      ),
    );
  }

  void toggleParental(bool val) {
    setState(() {
      parentalControl = val;
    });
  }

  getToggles() async {
    // await Future.delayed(Duration(microseconds: 10));
    settingsToggles = [
      SettingsToggleItem(toggleIcon: Icon(Icons.notifications, size: 27), toggleTitle: 'notifications'.tr(), callbackAction: () {}, toggleValue: true),
      SettingsToggleItem(toggleIcon: FaIcon(FontAwesomeIcons.video, size: 27), toggleTitle: 'video_autoplay'.tr(), callbackAction: () {}, toggleValue: false),
      SettingsToggleItem(toggleIcon: Icon(Icons.dark_mode, size: 27), toggleTitle: 'night_mode'.tr(), callbackAction: () {}, toggleValue: false),
      SettingsToggleItem(toggleIcon: Icon(Icons.location_pin, size: 27), toggleTitle: 'local_stories'.tr(), callbackAction: () {}, toggleValue: true),
    ];
    tileItems = [
      ContactItem(leading: Icon(Icons.info), title: 'about_us'.tr()),
      ContactItem(leading: Icon(Icons.phone), title: 'contact'.tr()),
      ContactItem(leading: Icon(Icons.star), title: 'response'.tr()),
      ContactItem(leading: Icon(Icons.edit), title: 'terms'.tr()),
      ContactItem(leading: Icon(Icons.edit_document), title: 'about_us'.tr()),
    ];
    setState(() {});
  }
}
