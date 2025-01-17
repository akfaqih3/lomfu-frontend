import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/helpers/cache.dart';

class AppThemeController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    getMode();
  }

  void getMode() async {
    final isDark = await Cache.getBool("isDark") ?? Get.isDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleMode() async {
    await Cache.setBool("isDark", !Get.isDarkMode);
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
