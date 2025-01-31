import 'package:get/get.dart';
import 'package:lomfu_app/themes/theme_service.dart';
import 'package:lomfu_app/helpers/localizition/language_service.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/modules/teacher/controller/course_controller.dart';
import 'package:lomfu_app/helpers/sync/sync_queu.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeService>(() => ThemeService(), fenix: true);
    Get.lazyPut<LanguageService>(() => LanguageService(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<CourseController>(() => CourseController(), fenix: true);
    
    Get.lazyPut<SyncQueu>(() => SyncQueu(), fenix: true);
  }
}
