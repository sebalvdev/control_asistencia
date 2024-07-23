import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';

class Message {
  final SharedPreferences sharedPreferences;

  Message({required this.sharedPreferences});

  String? getMessage() {
    return sharedPreferences.getString(errorMessageCache);
  }

  SnackBar snackBar() {
    return SnackBar(
      content: Text(getMessage() ?? "QR Incorrecto"),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 2),
    );
  }
}
