import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String? text;
  double fontSize;
  Color? color;
  Alignment alignment;
  FontWeight? fontWeight;
  TextOverflow? overflow;
  double? height;
  int? maxLines;
  TextAlign? textAlign;

  CustomText(
      {this.text = "",
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment = Alignment.centerLeft,
      this.overflow,
      this.height,
      this.maxLines,
      this.textAlign,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(text!,
          overflow: overflow,
          textAlign: textAlign,
          maxLines: maxLines,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
              height: height)),
    );
  }
}
