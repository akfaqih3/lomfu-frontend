import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/themes/app_theme.dart';
import 'package:lomfu_app/themes/theme_service.dart';
import 'package:lomfu_app/config/binding.dart';
import 'package:lomfu_app/helpers/localizition/language_service.dart';
import 'package:lomfu_app/helpers/localizition/translate.dart';

late LanguageService AppLanguage;
late ThemeService AppTheme;

class AppHome extends StatelessWidget {
  const AppHome({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.getPages,
      initialBinding: AppBinding(),
      translations: Translate(),
      locale: Get.deviceLocale,
    );
  }
}
