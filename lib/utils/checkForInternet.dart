import 'dart:io';

import 'globals.dart';

class InternetConnectivity {
  checkForConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        hasActiveConnection = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      hasActiveConnection = false;
    }
  }
}
