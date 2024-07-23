import 'dart:convert';
import 'package:control_asistencia_2/features/check_assistance/presentation/widgets/location.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/cache_constants.dart';
import 'get_user_info.dart';

class FindAssistance {

  final SharedPreferences sharedPreferences;

  FindAssistance({required this.sharedPreferences});

  String getCurrentDay() {
    final now = DateTime.now();
    final dayFormat = DateFormat.EEEE('es_ES');
    return dayFormat.format(now);
  }
  
  Future<Map<String, dynamic>> findAssistance({required String qrCode,}) async {
    final userInfo = sl<UserInfo>();
    final code = sharedPreferences.getString(serverCache);

    final apiUrl = 'https://jcvctechnology.com/$code/api/api.php';

    final userId = await userInfo.getUserId();
    final day = getCurrentDay();
    final latitude = await Location().getLatitude();
    final longitude = await Location().getLongitude();
    // 0221170583347694

    final response = await http.get(
      Uri.parse('$apiUrl?find=$qrCode&id_user=$userId&day=$day&latitude=$latitude&longitude=$longitude'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load assistance data');
    }
  }
}
