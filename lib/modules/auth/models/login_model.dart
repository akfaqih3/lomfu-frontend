import 'package:lomfu_app/API/api_const.dart';

class LoginModel {
  final String accessToken;
  final String refreshToken;

  LoginModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json[APIKeys.accessToken],
      refreshToken: json[APIKeys.refreshToken],
    );
  }
}
