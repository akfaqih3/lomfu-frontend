import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/helpers/SQL/db_helper.dart';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';
import 'package:lomfu_app/modules/teacher/services/api_service.dart';
import 'package:lomfu_app/modules/teacher/services/sql_service.dart';
import 'package:lomfu_app/helpers/async/async_queu.dart';

class CourseController extends GetxController {
  final APIService _apiService = APIService();
  final SQLService _sqlService = SQLService();
  final courselist = RxList<CourseModel>();
  final loading = false.obs;

  var subjects = Get.find<HomeController>().subjects;
  var selectedSubject;
  var titleEditTextController = TextEditingController();
  var overviewEditTextController = TextEditingController();
  var subjectEditTextController = TextEditingController();
  Rx<File?> courseImage = Rx<File?>(null);

  final DbHelper _dbHelper = DbHelper();

  @override
  void onInit() async {
    super.onInit();
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    loading(true);
    try {
      // final response = await _apiService.getCourses();
      final response = await _sqlService.getCourses();
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

      await _sqlService.createCourse(
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
        photo,
      );
      
      await AsyncQueue().addCourse(
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
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

  void updateCourse(int id) async {
    try {
      loading(true);
      final photo = courseImage.value ?? null;

      await _sqlService.updateCourse(
        id,
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
        photo ,
      );

      await AsyncQueue().updateCourse(
        id,
        selectedSubject,
        titleEditTextController.text,
        overviewEditTextController.text,
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

  void deleteCourse(int id) async {
    try {
      loading(true);
      await _sqlService.deleteCourse(id);

      await AsyncQueue().deleteCourse(id);


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
