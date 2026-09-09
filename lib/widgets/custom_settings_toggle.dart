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
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: Theme.of(context).shadowColor.withAlpha(150)),

      child: Column(
        children: [
          widget.settingsToggleItem.toggleIcon,
          SizedBox(height: 10),
          CustomText(text: widget.settingsToggleItem.toggleTitle),
          SizedBox(height: 10),

          Switch(
            value: widget.settingsToggleItem.toggleValue,
            onChanged: (val) {
              print(val);
              widget.settingsToggleItem.toggleValue = val;
              widget.settingsToggleItem.callbackAction;
              setState(() {
                
              });
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
  final VoidCallback callbackAction;

  SettingsToggleItem({required this.toggleIcon, required this.toggleTitle, required this.callbackAction, required this.toggleValue});
}
