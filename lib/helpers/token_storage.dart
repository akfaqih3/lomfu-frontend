import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static String _accessTokenKey = 'accessToken';
  static String _refreshTokenKey = 'refreshToken';

  static Future<void> saveToken(String accessToken, String refreshToken) async {
    await GetStorage().write(_accessTokenKey, accessToken);
    await GetStorage().write(_refreshTokenKey, refreshToken);
  }

  static Future<void> removeToken() async {
    await GetStorage().remove(_accessTokenKey);
    await GetStorage().remove(_refreshTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return GetStorage().read(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return GetStorage().read(_refreshTokenKey);
  }
}
