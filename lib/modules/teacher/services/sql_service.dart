import 'dart:io';

import 'package:lomfu_app/helpers/SQL/db_helper.dart';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:sqflite/sqflite.dart';

class SQLService {
  final DbHelper _dbHelper = DbHelper();

  Future<List<CourseModel>> getCourses() async {
    final response = await _dbHelper.read(SqlKeys.courseTable);
    return List.generate(
        response.length, (index) => CourseModel.fromSql(response[index]));
  }

  Future<int> createCourse(
      String subject, String title, String overview, File? photo) async {
    final photoBytes = photo == null ? null : await photo.readAsBytes();

    final id = await _dbHelper.create(SqlKeys.courseTable, {
      SqlKeys.courseSubject: subject,
      SqlKeys.courseTitle: title,
      SqlKeys.courseOverview: overview,
      SqlKeys.coursePhoto: photoBytes,
      SqlKeys.courseCreatedAt: DateTime.now().toString(),
    });
    return id;
  }

  Future<void> updateCourse(int id, String subject, String title,
      String overview, File? photo) async {
    final photoBytes = photo == null ? null : await photo.readAsBytes();
    await _dbHelper.update(
        SqlKeys.courseTable,
        {
          SqlKeys.courseSubject: subject,
          SqlKeys.courseTitle: title,
          SqlKeys.courseOverview: overview,
          if (photoBytes != null) SqlKeys.coursePhoto: photoBytes,
          SqlKeys.courseCreatedAt: DateTime.now().toString(),
        },
        where: "${SqlKeys.courseID} = $id",);
  }

  Future<void> deleteCourse(int id) async {
    await _dbHelper.delete(SqlKeys.courseTable,
        where: "${SqlKeys.courseID} = $id");
  }
}
