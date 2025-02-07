import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/API/api_const.dart';

class LinkHandlerService {
  final AppLinks _appLinks = AppLinks();
  final APIHelper _apiHelper = APIHelper();

  Future<void> initDeepLinks() async {
    try {
      final Uri? uri = await _appLinks.getInitialLink();
      if (uri != null) {
        _handleLink(uri);
      }

      _appLinks.uriLinkStream.listen((Uri uri) {
        _handleLink(uri);
      });
    } catch (e) {
      debugPrint("Error in deep linking: $e");
    }
  }

  void _handleLink(Uri uri) async {
    if (uri.queryParameters.containsKey('code')) {
      try{
        String code = uri.queryParameters['code'] ?? '';
        final response = await _apiHelper.get('${Endpoints.googleLogin}?code=$code');
      }on ApiExceptions catch(e){
        Get.snackbar('Error',e.error.message);
      }
    }
  }
}
