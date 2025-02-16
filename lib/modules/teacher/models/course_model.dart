import 'dart:io';
import 'dart:typed_data';

import 'package:lomfu_app/SQL/sql_consts.dart';
import 'package:lomfu_app/API/api_const.dart';

class CourseModel {
  final int? localId;
  final int? serverId;
  final String? teacher;
  final String title;
  final String subject;
  final String overview;
  final String? photo;
  final Uint8List? photoBytes;
  final int? totalStudents;
  final int? totalModules;
  final String? createdAt;

  CourseModel({
    this.localId,
    this.serverId,
    required this.teacher,
    required this.title,
    required this.subject,
    required this.overview,
    this.photo,
    this.photoBytes,
    this.totalStudents,
    this.totalModules,
    this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      serverId: json[APIKeys.courseId],
      teacher: json[APIKeys.courseTeacher],
      title: json[APIKeys.courseTitle],
      subject: json[APIKeys.courseSubject],
      overview: json[APIKeys.courseOverview],
      photo: json[APIKeys.coursePhoto],
      totalStudents: json[APIKeys.courseTotalStudents],
      totalModules: json[APIKeys.courseTotalModules],
      createdAt: json[APIKeys.courseCreated] ?? null,
    );
  }

  factory CourseModel.fromSql(Map<String, dynamic> row) {
    return CourseModel(
      localId: row[SqlKeys.courseLocalID],
      serverId: row[SqlKeys.courseServerID] ?? 0,
      teacher: null,
      title: row[SqlKeys.courseTitle],
      subject: row[SqlKeys.courseSubject],
      overview: row[SqlKeys.courseOverview],
      photoBytes: row[SqlKeys.coursePhoto],
      totalStudents: 0,
      totalModules: 0,
      createdAt: row[SqlKeys.courseCreatedAt],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      APIKeys.courseId: serverId,
      APIKeys.courseTitle: title,
      APIKeys.courseSubject: subject,
      APIKeys.courseOverview: overview,
      APIKeys.coursePhoto: photo,
      APIKeys.courseCreated: createdAt,
    };
  }
}
