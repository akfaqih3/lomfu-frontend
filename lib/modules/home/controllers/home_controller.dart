import 'dart:io';

import 'package:get/get.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/helpers/SQL/db_helper.dart';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';

class HomeController extends GetxController {
  final _apiService = APIHelper();
  final isLoading = false.obs;
  final subjects = <SubjectModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await getSubjects();
    // await saveSubjects();
  }

  Future<void> getSubjects() async {
    try {
      isLoading(true);
      final bool isConnected = await NetworkHelper.isConnected();
      final response = isConnected
          ? await _apiService.get(Endpoints.subjects)
          : await DbHelper().read(SqlKeys.subjectTable);

      subjects.clear();
      subjects.value = isConnected? (response.body as List)
          .map((json) => SubjectModel.fromJson(json))
          .toList() : List.generate(
          response.length, (index) => SubjectModel.fromSql(response[index]));
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

  // save subjects to local storage
  Future<void> saveSubjects() async {
    final _dbHelper = DbHelper();

    for (SubjectModel subjectModel in subjects) {
      // final photo = await File.fromUri(Uri.http(baseUrl, subjectModel.photo!.replaceFirst("/", "")))
      //     .readAsBytes();
      _dbHelper.create(SqlKeys.subjectTable, {
        SqlKeys.subjectSlug: subjectModel.slug,
        SqlKeys.subjectTitle: subjectModel.title,
        SqlKeys.subjectCoursesTotal: subjectModel.coursestotal,
      });
    }
  }
}
