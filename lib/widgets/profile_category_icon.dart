import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileCategory extends StatelessWidget {
  final CategoryItem categoryItem;
  const ProfileCategory({super.key, required this.categoryItem});

  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Theme.of(context).shadowColor,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(categoryItem.categoryImage, height: 50,fit: BoxFit.contain,),
          CustomText(text: categoryItem.categoryTitle),
        ],
      ),
    );
  }
}

class CategoryItem {
  final String categoryImage;
  final String categoryTitle;

  CategoryItem({required this.categoryImage, required this.categoryTitle});
}
