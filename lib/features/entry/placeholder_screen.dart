import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/widgets/custom_text.dart';

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: darkTextColor,
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text(
          "Coming Soon!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0179CB),
          ),
        ),
      ),
    );
  }
}
