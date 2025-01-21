import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/home.dart';
import 'package:lomfu_app/helpers/localizition/language_service.dart';
import 'package:lomfu_app/themes/theme_service.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLanguage = Get.find<LanguageService>();
    AppTheme = Get.find<ThemeService>();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    Future.delayed(const Duration(milliseconds: 500), () {
      Get.offNamed(Pages.home);
    });

    return Scaffold(
      body: Center(
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
              lblWelcome.tr + appName.tr,
              style: Get.textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
