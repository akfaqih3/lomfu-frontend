import 'package:flutter/widgets.dart';

const String baseUrl = 'https://lomfu.pythonanywhere.com/';

const String apiKey = 'api/';

const String version = 'v1/';

const int timeout = 5000;

const Map<String, String> apps = {
  'accounts': 'accounts/',
  'teachers': 'teachers/',
  'courses': 'courses/',
};

class Endpoints {
  //general endpoints
  static String refreshToken =
      "$apiKey$version${apps['accounts']}token/refresh/";

  //accounts endpoints
  static String login = "$apiKey$version${apps['accounts']}login/";
  static String logout = "$apiKey$version${apps['accounts']}logout/";
  static String register = "$apiKey$version${apps['accounts']}register/";
  static String verifyEmail = "$apiKey$version${apps['accounts']}otp-verify/";
  static String resendOTP = "$apiKey$version${apps['accounts']}otp-send/";
  static String forgotPassword =
      "$apiKey$version${apps['accounts']}password-reset/";
  static String resetPassword =
      "$apiKey$version${apps['accounts']}password-reset/confirm/";
  static String subjects = "$apiKey$version${apps['courses']}subjects/";

  //teachers endpoints
  static String teachersCourses = "$apiKey$version${apps['teachers']}courses/";
  static String teachersAddCourse =
      "$apiKey$version${apps['teachers']}courses/create/";
  static String teachersDeleteCourse =
      "$apiKey$version${apps['teachers']}courses/";
}

class APIKeys {
  static String token = 'token';
  static String accessToken = 'access';
  static String refreshToken = 'refresh';
  static String tokenType = 'Bearer';

  static String detail = 'detail';
  static String message = 'message';
  static String status = 'status';
  static String errors = 'errors';

  // error messages
  static String invalidToken = 'Given token not valid for any token type';

  static const String name = 'name';
  static const String email = 'email';
  static const String role = 'role';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String confirmPassword = 'confirm_password';
  static const String photo = 'photo';
  static const String bio = 'bio';

  static const String oldPassword = 'old_password';
  static const String newPassword = 'new_password';
  static const String otp = 'otp';

  //subjects
  static const String subjectId = 'id';
  static const String subjectTitle = 'title';
  static const String subjectSlug = 'slug';
  static const String subjectphoto = 'photo';
  static const String subjectCoursesTotal = 'total_courses';

  //courses
  static const String courseId = 'id';
  static const String courseTitle = 'title';
  static const String courseSubject = 'subject';
  static const String courseOverview = 'overview';
  static const String coursePhoto = 'photo';
  static const String courseCreated = 'created';
}
