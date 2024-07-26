// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';
import '../constants/domain.dart';

class Notifications {

  final SharedPreferences sharedPreferences;

  Notifications({required this.sharedPreferences});

  Future<bool> verifyNotifications() async {
    final lastMessages = sharedPreferences.getString(lastMessagesCache);
    final newMessages = await fetchNotifications();
    return lastMessages == newMessages;
  }

  Future<String> fetchNotifications() async {
    final code = sharedPreferences.getString(serverCache);
    final codeVerification = sharedPreferences.getInt(codeCache).toString();

    // String key = "https://jcvctechnology.com/$code/api/api.php";
    String key = "https://$domainName/$code/api/api.php";
    final operation = "?notifications=$codeVerification";
    final url = Uri.parse(key + operation);

    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return "";
  }

  Future<List<dynamic>> getNotifications() async {
    final newNotifycations = await fetchNotifications();
        final List<dynamic> data = json.decode(newNotifycations);
        if (data.isNotEmpty) {
          // Ordenar la lista por 'notifications_id' en orden descendente
          data.sort((a, b) => (int.parse(b['notifications_id'])).compareTo(int.parse(a['notifications_id'])));
          sharedPreferences.setString(lastMessagesCache, newNotifycations);
          return data;
        } else {
          print('No hay notificaciones');
        }
    return [];
  }
}
