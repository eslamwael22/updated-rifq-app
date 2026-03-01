import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  static Future<bool> checkNetworkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  static Future<bool> hasFullConnection() async {
    final network = await checkNetworkConnection();
    if (!network) {
      return false;
    }
    final internet = await checkConnection();
    return internet;
  }
}
