import 'dart:io';
import 'dart:typed_data';

import 'package:lomfu_app/API/api_const.dart ';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';

class CourseModel {
  final int id;
  final String title;
  final String subject;
  final String overview;
  final String? photo;
  final Uint8List? photoBytes;
  final String createdAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.overview,
    this.photo,
    this.photoBytes,
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

  factory CourseModel.fromSql(Map<String, dynamic> row) {

    return CourseModel(
      id: row[SqlKeys.courseID],
      title: row[SqlKeys.courseTitle],
      subject: row[SqlKeys.courseSubject],
      overview: row[SqlKeys.courseOverview],
      photoBytes: row[SqlKeys.coursePhoto],
      createdAt: row[SqlKeys.courseCreatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      APIKeys.courseId: id,
      APIKeys.courseTitle: title,
      APIKeys.courseSubject: subject,
      APIKeys.courseOverview: overview,
      APIKeys.coursePhoto: photo,
      APIKeys.courseCreated: createdAt,
    };
  }
}
