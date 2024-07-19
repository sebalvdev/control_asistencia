import 'package:control_asistencia_2/core/constants/cache_constants.dart';
// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logo {
  
  late final SharedPreferences sharedPreferences;

  Logo({required this.sharedPreferences});
  
  Future<String> getLogo() async {
    final route = sharedPreferences.getString(serverCache);
    final logo = "https://jcvctechnology.com/$route/images/logos/logo.jpg";
    // final logo = 'https://jcvctechnology.com/asistenciaonline/images/logos/logo.jpg';
    return logo;
  }
}