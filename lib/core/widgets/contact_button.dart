import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/colors.dart';
import 'custom_text.dart';

class ContactButton extends StatelessWidget {
  final String text;
  final String iconPath;
  final double? width;
  final double? height;

  const ContactButton({
    super.key,
    required this.text,
    required this.iconPath,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: SizedBox(
        width: 100,
        height: 34,
        child: OutlinedButton.icon(
          onPressed: () {},
          icon: SvgPicture.asset(
            iconPath,
            height: height ?? 10,
            width: width ?? 18,
          ),
          label: CustomText(
            text: text,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: primaryColor,
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: primaryColor),
            shape: const StadiumBorder(),
            padding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
