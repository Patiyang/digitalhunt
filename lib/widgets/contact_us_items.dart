import 'package:digitalhunt/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ContactUsTile extends StatelessWidget {
  final ContactItem contactItem;
  const ContactUsTile({super.key, required this.contactItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
      decoration: BoxDecoration(color: Theme.of(context).shadowColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          contactItem.leading,
          SizedBox(width: 10),
          CustomText(text: contactItem.title),
          Spacer(),
          contactItem.trailing,
        ],
      ),
    );
  }
}

class ContactItem {
  final Icon leading;
  final String title;
  final Widget trailing;

  ContactItem({required this.leading, required this.title, this.trailing = const Icon(Icons.arrow_forward_ios)});
}
