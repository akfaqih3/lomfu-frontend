import 'dart:io';

import 'package:get/get.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';

class HomeController extends GetxController {
  final _apiService = Get.find<APIHelper>();
  final isLoading = false.obs;
  var subjects = <SubjectModel>[].obs;
  final isConnected = false.obs;

  @override
  void onInit() async {
    isConnected(await NetworkHelper.isConnected());
    super.onInit();
    subjects.value = await getSubjects();
  }

  Future<List<SubjectModel>> getSubjects() async {
    List<SubjectModel> _subjects = [];
    try {
      isLoading(true);

      final response = await NetworkHelper.isConnected()
          ? await _apiService.get(Endpoints.subjects)
          : await DbHelper().read(SqlKeys.subjectTable);

      subjects.clear();
      _subjects = await NetworkHelper.isConnected()
          ? (response.body as List)
              .map((json) => SubjectModel.fromJson(json))
              .toList()
          : List.generate(response.length,
              (index) => SubjectModel.fromSql(response[index]));
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    } finally {
      isLoading(false);
    }
    return _subjects;
  }

  void logout() {
    Get.offAllNamed(Pages.login);
  }
}
