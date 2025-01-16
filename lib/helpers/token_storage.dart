import 'package:lomfu_app/helpers/cache.dart';

class TokenStorage {
  static String _accessTokenKey = 'accessToken';
  static String _refreshTokenKey = 'refreshToken';

  static Future<void> saveToken(String accessToken, String refreshToken) async {
    await Cache.set(_accessTokenKey, accessToken);
    await Cache.set(_refreshTokenKey, refreshToken);
  }

  static Future<void> removeToken() async {
    await Cache.remove(_accessTokenKey);
    await Cache.remove(_refreshTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return await Cache.get(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await Cache.get(_refreshTokenKey);
  }
}
