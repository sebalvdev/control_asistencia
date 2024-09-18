// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';
import '../constants/domain.dart';
class GetUnique {

  final SharedPreferences sharedPreferences;

  GetUnique({required this.sharedPreferences});

  Future<String> obtaunUniqueNumber() async {
    var result = "";

    
    final code = sharedPreferences.getString(serverCache);

    String key = "https://$domainName/$code/api/api.php";
    const operation = "?get_unique";
    final url = Uri.parse(key + operation);

    try
    {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          // Código único generado
          result = data['key'];
        } else {
          // No se pudo generar un código único
          print('No se pudo generar un código único');
        }
      } else {
        // Error en la solicitud
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    return result;
  }
}
