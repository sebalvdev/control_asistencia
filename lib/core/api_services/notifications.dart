// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';

class Notifications {

  final SharedPreferences sharedPreferences;

  Notifications({required this.sharedPreferences});

  Future<List> obtenerNotificaciones(String codigo) async {
    final server = sharedPreferences.getString(serverCache);
    final String baseUrl = 'https://jcvctechnology.com/$server/api/api.php';
    final response = await http.get(
      Uri.parse('$baseUrl?notifications=$codigo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Ordenar la lista por 'notifications_id' en orden descendente
        data.sort((a, b) => (int.parse(b['notifications_id'])).compareTo(int.parse(a['notifications_id'])));

        for (var notificacion in data) {
          print(notificacion);
        }
        
        return data;
      } else {
        print('No hay notificaciones');
        return [];
      }
    } else {
      print('Error en la solicitud: ${response.statusCode}');
      return [];
    }
  }
}
