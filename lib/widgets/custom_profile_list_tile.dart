import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProfileListTile extends StatefulWidget {
  final CustomProfileListTile customProfileListTile;
  const ProfileListTile({super.key, required this.customProfileListTile});

  @override
  State<ProfileListTile> createState() => _ProfileListTileState();
}

class _ProfileListTileState extends State<ProfileListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.customProfileListTile.leadingImage,
      title: CustomText(text: widget.customProfileListTile.title),
      // titleTextStyle: TextStyle(fontSize: 14),textColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
      trailing: widget.customProfileListTile.trailing,
      onTap: widget.customProfileListTile.callback,
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
    );
  }
}

class CustomProfileListTile {
  final Icon leadingImage;
  final String title;
  final Widget trailing;
  final VoidCallback callback;

  CustomProfileListTile({
    required this.leadingImage,
    required this.title,
    this.trailing = const Icon(Icons.arrow_forward_ios, size: 18),
    required this.callback,
  });
}
