import 'package:booking_app/widgets_model/custom_text.dart';
import 'package:flutter/material.dart';

class CustomContainerPlanning extends StatelessWidget {
  final String text;
  const CustomContainerPlanning({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey)),
      child: CustomText(
        text: text,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        alignment: Alignment.center,
      ),
    );
  }
}
