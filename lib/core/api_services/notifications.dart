// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';

class Notifications {

  final SharedPreferences sharedPreferences;

  Notifications({required this.sharedPreferences});

  Future<bool> verifyNotifications() async {
    
    return await getNotifications() == test;
  }

  // List<dynamic> getNotifications() {
  List<dynamic> test() {
    final messages = sharedPreferences.getString(lastMessagesCache);
    print(messages);
    // if(messages == null) {
    //   return [];
    // } else {
    List<dynamic> result = jsonDecode(messages ?? "{}");
    return result;
    // }
  }

  Future<dynamic> getNotifications() async {
  // Future<void> fetchNotifications() async {
    final code = sharedPreferences.getString(serverCache);
    final codeVerification = sharedPreferences.getInt(codeCache).toString();

    String key = "https://jcvctechnology.com/$code/api/api.php";
    final operation = "?notifications=$codeVerification";
    final url = Uri.parse(key + operation);

    
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // print(data);
        if (data.isNotEmpty) {
          // Ordenar la lista por 'notifications_id' en orden descendente
          data.sort((a, b) => (int.parse(b['notifications_id'])).compareTo(int.parse(a['notifications_id'])));

          // for (var notificacion in data) {
          //   print(notificacion);
          // }
          // print(jsonEncode(data));
          sharedPreferences.setString(newMessagesCache, jsonEncode(data));
          return data;
        } else {
          print('No hay notificaciones');
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return [];
  }
}
