import 'package:get/get.dart';
import 'package:lomfu_app/themes/app_theme_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppThemeController>(() => AppThemeController(), fenix: true);
  }
}
