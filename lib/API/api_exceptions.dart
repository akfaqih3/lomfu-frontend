import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';

class ErrorModel {
  final int? statusCode;
  final String message;

  ErrorModel(this.statusCode, this.message);

  factory ErrorModel.fromJson(Response json) {
    return ErrorModel(json.statusCode, json.body[APIKeys.detail]);
  }
}

class ApiExceptions implements Exception {
  final ErrorModel error;

  ApiExceptions(this.error);
}

// handle errors
errorHandler(ApiExceptions e) {
  switch (e.error.statusCode) {
    case 401:
      Get.snackbar("Error", e.error.message);
      break;
    case 400:
      Get.snackbar("Error", e.error.message);
      break;
    case 403:
      Get.snackbar("Error", e.error.message);
      break;
    case 404:
      Get.snackbar("Error", e.error.message);
      break;
    case 500:
      Get.snackbar("Error", e.error.message);
      break;
    default:
      Get.snackbar("Error", e.error.message);
      break;
  }
}
