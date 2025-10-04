import 'package:flutter/material.dart';

import '../../core/constants/colors.dart';
import '../../core/services/restart_app.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              child: Image.asset('assets/images/no_connection.png'),
            ),
            const CustomText(
              marginTop: 50,
              color: blackColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              text:
                  "Whoops! \n No internet connection was found. Check your connection and try again",
            ),
            CustomButton(
              marginTop: 50,
              onPressed: () {
                RestartWidget.restartApp(context);
              },
              text: "Refresh",
            ),
          ],
        ),
      ),
    );
  }
}
