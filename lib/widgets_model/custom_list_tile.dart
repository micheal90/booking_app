import 'package:flutter/material.dart';

import 'package:booking_app/widgets_model/custom_text.dart';

class CustomListTile extends StatelessWidget {
final  Widget? leading;
 final String? title;
 final  Function()? onTap;
   CustomListTile({
    Key? key,
    this.leading,
    this.title,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      onTap: onTap,
      title: CustomText(
        text: title,
      
      ),
    );
  }
}
