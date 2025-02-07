import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/modules/home/services/api_service.dart';
import 'package:lomfu_app/modules/home/services/sql_service.dart';

class HomeController extends GetxController {
  final _apiService = ApiService();
  final _sqlService = SqlService();
  final isLoading = false.obs;
  final isConnected = false.obs;
  var subjects = <SubjectModel>[].obs;
  var courses = <CourseModel>[].obs;

  @override
  void onInit() async {
    isConnected(await NetworkHelper.isConnected());
    super.onInit();
    subjects.value = await getSubjects();
  }

  @override
  void onReady() async {
    super.onReady();
    courses.value = await _apiService.getCourses();
  }

  Future<List<SubjectModel>> getSubjects() async {
    List<SubjectModel> _subjects = [];
    try {
      isLoading(true);

      _subjects = await NetworkHelper.isConnected()
          ? await _apiService.getSubjects()
          : await _sqlService.getSubjects();
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
    return _subjects;
  }

  void logout() {
    Get.offAllNamed(Pages.login);
  }

 
}
