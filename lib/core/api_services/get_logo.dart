import 'package:control_asistencia_qr/core/constants/cache_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/domain.dart';

class Logo {
  
  final SharedPreferences sharedPreferences;

  Logo({required this.sharedPreferences});
  
  Future<String> getLogo() async {
    final route = sharedPreferences.getString(serverCache);
    // final logo = "https://jcvctechnology.com/$route/images/logos/logo.jpg";
    final logo = "https://$domainName/$route/images/logos/logo.jpg";
    return logo;
  }
}