
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;
  final isFirstOpen = GetStorage().read('isFirstOpen') ?? true;

  @override
  void onInit() async {
    super.onInit();
    if (isFirstOpen) {
      await saveSubjects();
    }
  }

  @override
  void onReady() {
    super.onReady();
    GetStorage().write('isFirstOpen', false);
  }

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/svg/onboarding1.svg",
      "title": "Numerous free trial courses",
      "description": "Free courses for you to find your way to learning ",
    },
    {
      "image": "assets/images/svg/onboarding2.svg",
      "title": "Quick and easy learning",
      "description":
          "Easy and fast learning at any time to help you improve various skills",
    },
    {
      "image": "assets/images/svg/onboarding3.svg",
      "title": "Create your own study plan",
      "description":
          "Study according to the study plan, make study more motivated",
    },
  ];

  // save subjects to local storage
  Future<void> saveSubjects() async {
    final _dbHelper = Get.find<DbHelper>();
    final subjects = await Get.find<HomeController>().getSubjects();

    for (SubjectModel subjectModel in subjects) {
      final photo = baseUrl + subjectModel.photo!.replaceFirst("/", "");
      _dbHelper.create(SqlKeys.subjectTable, {
        SqlKeys.subjectTitle: subjectModel.title,
        SqlKeys.subjectSlug: subjectModel.slug,
        SqlKeys.subjectPhoto: photo,
        SqlKeys.subjectCoursesTotal: subjectModel.coursestotal,
      });
    }
  }
}
