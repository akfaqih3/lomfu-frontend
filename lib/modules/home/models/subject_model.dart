import 'dart:io';

import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';

class SubjectModel {
  final String slug;
  final String title;
  final String? photo;
  final File? photoBytes;
  final int? coursestotal;

  SubjectModel({
    required this.slug,
    required this.title,
    this.photo,
    this.photoBytes,
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

  factory SubjectModel.fromSql(Map<String, dynamic> row) {
    return SubjectModel(
      slug: row[SqlKeys.subjectTitle],
      title: row[SqlKeys.subjectSlug],
      coursestotal: row[SqlKeys.subjectCoursesTotal],
    );
  }
}
