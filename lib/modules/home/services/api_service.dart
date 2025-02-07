import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

class ApiService {
  final _apiHelper = Get.find<APIHelper>();

  Future<List<CourseModel>> getCourses({
    int? index,
    int? size,
    String? ordering,
    String? search,
    String? ownerName,
    String? subjectSlug,
  }) async {
    final Map<String, dynamic> query = {
      APIKeys.index: index.toString() ?? "0",
      APIKeys.size: size.toString() ?? "10",
      APIKeys.ordering: ordering ?? "created",
      APIKeys.search: search ?? "",
      APIKeys.owner__name: ownerName ?? "teacher",
      APIKeys.subject__slug: subjectSlug ?? "",
    };
    final response = await _apiHelper.get(Endpoints.courses, query: query);
    if (response.statusCode == 200) {
      return (response.body[APIKeys.results] as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
    } else {
      throw Exception("REQUEST BAD");
    }
  }

  Future<List<SubjectModel>> getSubjects() async {
    final response = await _apiHelper.get(Endpoints.subjects);
    if (response.statusCode == 200) {
      return (response.body as List)
          .map((json) => SubjectModel.fromJson(json))
          .toList();
    } else {
      throw Exception("REQUEST BAD");
    }
  }
}
