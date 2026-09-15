import 'package:digitalhunt/utils/config/config.dart';
import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:digitalhunt/widgets/profile_category_icon.dart';
import 'package:flutter/material.dart';

class HomeCategoryCard extends StatelessWidget {
  final CategoryItem categoryItem;
  final int index;
  final int total;

  const HomeCategoryCard({super.key, required this.categoryItem, required this.index, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(Config().icon),fit: BoxFit.contain,),
        color: Theme.of(context).shadowColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListTile(
            leading: CustomText(text: index.toString(), size: 45, fontWeight: FontWeight.bold),
            title: CustomText(text: categoryItem.categoryTitle),
            subtitle: CustomText(text: '${'of'} $total'),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          ),
          Spacer(),
          CustomText(text: categoryItem.categoryTitle, size: 18, fontWeight: FontWeight.w500),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(text: categoryItem.categoryTitle, color: Config().appColor),
              SizedBox(width: 10),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),          SizedBox(height: 10),

        ],
      ),
    );
  }
}
