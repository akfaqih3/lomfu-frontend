import 'package:get/get.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

class CourseDetailController extends GetxController {
  CourseModel? course;

  @override
  void onInit() {
    super.onInit();
    course = Get.arguments["course"];
  }
}
