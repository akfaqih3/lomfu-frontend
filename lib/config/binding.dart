import 'package:get/get.dart';
import 'package:lomfu_app/themes/theme_service.dart';
import 'package:lomfu_app/helpers/localizition/language_service.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeService>(() => ThemeService(), fenix: true);
    Get.lazyPut<LanguageService>(() => LanguageService(), fenix: true);
  }
}
