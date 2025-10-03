import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    this.text = "",
    this.fontWeight = FontWeight.w400,
    this.color = blackColor,
    this.textAlign = TextAlign.start,
    this.fontSize = 20.0,
    this.marginTop = 0.0,
    this.marginBottom = 0.0,
    this.marginLeft = 0.0,
    this.marginRight = 0.0,
    this.height = 1.0,
    this.underline = false,
    this.shadows = false,
  });
  final String text;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final double marginTop;
  final double marginBottom;
  final double marginLeft;
  final double marginRight;
  final double height;
  final bool underline;
  final bool shadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight,
        bottom: marginBottom,
      ),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          decoration: underline ? TextDecoration.underline : null,
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          height: height,
        ),
      ),
    );
  }
}
