import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FavLocationCard extends StatelessWidget {
  final String district_name;
  const FavLocationCard({super.key, required this.district_name});

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      color: Theme.of(context).primaryColor.withAlpha(50),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListTile(contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
          leading: FaIcon(FontAwesomeIcons.locationDot, size: 14),
          title: CustomText(
            maxLines: 2,
            text: district_name, overflow: TextOverflow.ellipsis, size: 16, fontWeight: FontWeight.w500),
          subtitle: CustomText(text: 'text'),
          trailing: FaIcon(FontAwesomeIcons.pencil, size: 14),
        ),
      ),
    );
  }
}
