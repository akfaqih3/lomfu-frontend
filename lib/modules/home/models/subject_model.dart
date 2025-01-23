import 'package:lomfu_app/API/api_const.dart';

class SubjectModel {
  final String slug;
  final String title;
  final String? photo;
  final int? coursestotal;

  SubjectModel({
    required this.slug,
    required this.title,
    this.photo,
    this.coursestotal,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      slug: json[APIKeys.subjectSlug],
      title: json[APIKeys.subjectTitle],
      photo: json[APIKeys.subjectphoto],
      coursestotal: json[APIKeys.subjectCoursesTotal],
    );
  }
}
