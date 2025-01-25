import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/modules/teacher/services/api_service.dart';
import 'package:lomfu_app/modules/teacher/services/sql_service.dart';
import 'package:lomfu_app/helpers/sync/sync_queu.dart';
import 'package:lomfu_app/helpers/network_helper.dart';

class CourseController extends GetxController {
  final APIService _apiService = APIService();
  final SQLService _sqlService = SQLService();
  final courselist = RxList<CourseModel>();
  final loading = false.obs;
  
  var subjects = Get.find<HomeController>().subjects ;
  var selectedSubject;
  var titleEditTextController = TextEditingController();
  var overviewEditTextController = TextEditingController();
  var subjectEditTextController = TextEditingController();
  Rx<File?> courseImage = Rx<File?>(null);

  final syncQueu = Get.find<SyncQueu>();

  @override
  void onInit() async {
    super.onInit();
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    loading(true);
    try {
      final response = await NetworkHelper.isConnected()
          ? await _apiService.getCourses()
          : await _sqlService.getCourses();
      courselist.clear();
      courselist.value = response;
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
    }
  }

  Future<void> addCourse() async {
    try {
      loading(true);
      final File? photo = courseImage.value ?? null;

      CourseModel? response;
      if (await NetworkHelper.isConnected()) {
        response = await _apiService.addCourse(
          selectedSubject,
          titleEditTextController.text,
          overviewEditTextController.text,
          photo,
        );
      }

      await _sqlService.createCourse(
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
        response == null ? 0 : response.serverId,
        0,
        photo,
      );

      Get.snackbar("Success", "Course Added");
      Get.back();
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
      await fetchCourses();
      clearForm();
    }
  }

  void updateCourse(int? localId, int? serverId) async {
    try {
      loading(true);
      final photo = courseImage.value ?? null;
      bool isupdated = false;

      if (await NetworkHelper.isConnected() && serverId != null) {
        await _apiService.updateCourse(
          serverId,
          selectedSubject,
          titleEditTextController.text,
          overviewEditTextController.text,
          photo,
        );
        isupdated = true;
      }

      await _sqlService.updateCourse(
        localId,
        serverId,
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
        isupdated,
        photo,
      );

      Get.snackbar("Success", "Course Updated");
      Get.back();
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
      await fetchCourses();
      clearForm();
    }
  }

  void deleteCourse(int? localId, int? serverId) async {
    try {
      loading(true);
      bool isDeleted = false;
      if (await NetworkHelper.isConnected() && serverId != null) {
        await _apiService.deleteCourse(serverId);
        isDeleted = true;
      }
      await _sqlService.deleteCourse(localId, serverId, isDeleted);

      Get.snackbar("Success", "Course Deleted");
      Get.back();
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
      await fetchCourses();
    }
  }

  void clearForm() {
    titleEditTextController.clear();
    overviewEditTextController.clear();
    subjectEditTextController.clear();
    selectedSubject = subjects.first.slug;
    courseImage.value = null;
  }
}
