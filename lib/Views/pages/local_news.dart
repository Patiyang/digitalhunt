import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalNews extends StatefulWidget {
  const LocalNews({super.key});

  @override
  State<LocalNews> createState() => _LocalNewsState();
}

class _LocalNewsState extends State<LocalNews> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child:  CustomText(text: 'local_news'.tr()),),);
  }
}