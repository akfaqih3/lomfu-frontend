import 'package:get/get.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_exceptions.dart';

class CourseController extends GetxController {
  final APIService _apiService = APIService();
  final courselist = RxList<CourseModel>();
  final loading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    loading(true);
    try {
      final response = await _apiService.get(Endpoints.teachersCourses);
      if (response.statusCode == 200) {
        courselist.clear();
        courselist.value = (response.body as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "REQUEST BAD");
      }
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
    }
  }
}
