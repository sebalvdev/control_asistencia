// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:control_asistencia_2/core/constants/cache_constants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import 'api.dart';

class AssistanceInfo {
  final SharedPreferences sharedPreferences;

  AssistanceInfo({required this.sharedPreferences});

  Future<Map<String, dynamic>> fetchLastCheck() async {
    final code = sharedPreferences.getString(serverCache);
    final userInfo = sl<UserInfo>();
    final userId = await userInfo.getUserId();

    String key = "https://jcvctechnology.com/$code/api/api.php";
    final operation = "?last_assistance=$userId";
    final url = Uri.parse(key + operation);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        if (data['success']) {
          final typeAssistance = data['type_assistance'];
          final lastDateTime = data['datetime_assistance'];
          final location = data['location'];

          DateTime dateTime = DateTime.parse(lastDateTime);
          String lastDate = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}';

          return {
            'type' : typeAssistance,
            'date' : lastDateTime,
            'hour' : lastDate,
            'location' : location,
          };
          // return '''  Ultima asistencia: $datetimeAssistance 
          //             Tipo: $typeAssistance''';
        } else {
          return {"message" : data['message']};
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return {};
  }


  Future<String> fetchAssistanceInfo() async {
    final code = sharedPreferences.getString(serverCache);
    final userInfo = sl<UserInfo>();
    final userId = await userInfo.getUserId();

    String key = "https://jcvctechnology.com/$code/api/api.php";
    final operation = "?last_assistance=$userId";
    final url = Uri.parse(key + operation);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['success']) {
          // DateTime now = DateTime.now();
          // String currentDateStr = DateFormat('yyyy-MM-dd').format(now);

          final datetimeAssistance = data['datetime_assistance'];
          // await sharedPreferences.setString(lastDateCache, currentDateStr);

          final lastDate = DateFormat('yyyy-MM-dd').parse(datetimeAssistance);
          await sharedPreferences.setString(lastDateCache, lastDate.toString());
          final typeAssistance = data['type_assistance'];

          return '''  Ultima asistencia: $datetimeAssistance 
                      Tipo: $typeAssistance''';
        } else {
          return "${data['message']}";
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return "";
  }

  // String getLastDate() {
  //   final result = sharedPreferences.getString(lastDateCache) ?? "-----------";
  //   String date = result.substring(0, 10);
  //   return date;
  // }
}
