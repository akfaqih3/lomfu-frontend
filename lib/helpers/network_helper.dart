import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkHelper {
  // static Future<bool> isConnected() async {
  //   final connectivityResult = await Connectivity().checkConnectivity();
  //   return connectivityResult == ConnectivityResult.mobile ||
  //       connectivityResult == ConnectivityResult.wifi;
  // }

  static Future<bool> isConnected() async {
    final result = await Process.run('ping', ['-c', '1', 'google.com']);
    return result.exitCode == 0;
  }

}
