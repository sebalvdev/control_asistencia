import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';

class Remotedatasource{
  
  Future<void> setServer(String server) async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    sharedPreferences.setString(serverCache, server);
  }
  
  Future<bool> verificar(String codigo) async {
    final url = "https://jcvctechnology.com/$codigo/api/api.php";
    try {
      final response = await http.get(Uri.parse(url));
      final result = response.statusCode == 200;
      if (result) {
      return result;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    } 
  }

  Future<Map<String, String>> extractDataFromJson(String jsonString) async {
    // Decodifica el JSON
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    // Extrae los valores necesarios
    final String nombre = jsonData['nombre'] ?? 'No name';
    final String foto = jsonData['foto'] ?? 'No photo';
    final String ubicacion = jsonData['ubicacion'] ?? 'No location';

    // Devuelve los valores en un mapa
    return {
      'nombre': nombre,
      'foto': foto,
      'ubicacion': ubicacion,
    };
  } 
}