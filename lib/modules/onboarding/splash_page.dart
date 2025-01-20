import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Get.offNamed(Pages.onboarding);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/lomfu.png",
                  width: 140,
                  height: 140,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Welcome to Lomfu",
                style: Get.textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
