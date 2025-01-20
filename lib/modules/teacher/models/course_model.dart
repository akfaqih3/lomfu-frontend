import 'package:lomfu_app/API/api_const.dart ';

class CourseModel {
  final int id;
  final String title;
  final String subject;
  final String overview;
  final String? photo;
  final String createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.overview,
    this.photo,
    required this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json[APIKeys.courseId],
      title: json[APIKeys.courseTitle],
      subject: json[APIKeys.courseSubject],
      overview: json[APIKeys.courseOverview],
      photo: json[APIKeys.coursePhoto],
      createdAt: json[APIKeys.courseCreated],
    );
  }
}
