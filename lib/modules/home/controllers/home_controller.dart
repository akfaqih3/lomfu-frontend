import 'package:get/get.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/API/api_const.dart';

class HomeController extends GetxController {
  final _apiService = APIService();
  final isLoading = false.obs;
  final subjects = <SubjectModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getSubjects();
  }

  Future<void> getSubjects() async {
    try {
      isLoading(true);
      final response = await _apiService.get(Endpoints.subjects);
      if (response.statusCode == 200) {
        subjects.clear();
        subjects.value = (response.body as List)
            .map((json) => SubjectModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "REQUEST BAD");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    } finally {
      isLoading(false);
    }
  }

  void logout() {
    Get.offAllNamed(Pages.login);
  }
}
