import 'package:get/get.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';

class SqlService {
  final _dbHelper = Get.find<DbHelper>();

  Future<List<SubjectModel>> getSubjects() async {
    final response = await _dbHelper.read(SqlKeys.subjectTable);
    return (response as List)
        .map((json) => SubjectModel.fromSql(json))
        .toList();
  }
} 