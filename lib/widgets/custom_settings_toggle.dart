import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationToggle extends StatefulWidget {
  final SettingsToggleItem settingsToggleItem;
  const NotificationToggle({super.key, required this.settingsToggleItem});

  @override
  State<NotificationToggle> createState() => _NotificationToggleState();
}

class _NotificationToggleState extends State<NotificationToggle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical:10, horizontal: 5),
      width: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Theme.of(context).shadowColor.withAlpha(150)),

      child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.settingsToggleItem.toggleIcon,
          SizedBox(height: 10),
          CustomText(text: widget.settingsToggleItem.toggleTitle, size: 13),
          SizedBox(height: 10),

          Switch(
            value: widget.settingsToggleItem.toggleValue,
            onChanged: (val) {
              print(val);
              widget.settingsToggleItem.toggleValue = val;
              // print(widget.settingsToggleItem.callbackAction);

              widget.settingsToggleItem.callbackAction.call();
              // setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class SettingsToggleItem {
  final Icon toggleIcon;
  final String toggleTitle;
  bool toggleValue;
  VoidCallback callbackAction;

  SettingsToggleItem({required this.toggleIcon, required this.toggleTitle, required this.callbackAction, required this.toggleValue});
}
