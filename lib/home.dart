import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/themes/app_theme.dart';
import 'package:lomfu_app/config/binding.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.getPages,
      initialBinding: AppBinding(),
    );
  }
}
