import 'dart:io';

import 'package:flutter/services.dart';

void exitApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop(); // Cierra la aplicación en Android
    } else if (Platform.isIOS) {
      exit(0); // Cierra la aplicación en iOS
    }
  }