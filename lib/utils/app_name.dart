import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  final double fontSize;
  const AppName({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Digital'.tr(),   //first part
        style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).textTheme.titleMedium!.color
            ),
        children: <TextSpan>[
          TextSpan(
              text: 'Hunt'.tr(),  //second part
              style:
                  TextStyle(fontFamily: 'Poppins',color: Theme.of(context).textTheme.titleMedium!.color)),
        ],
      ),
    );
  }
}
