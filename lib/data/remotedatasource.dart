import 'dart:convert';

class Remotedatasource{
  final String codigoCorrecto = '1234';
  
  void verificar(String codigo, Function(bool) callback) {
    if (codigo == codigoCorrecto) {
      callback(true); // Llama al callback con true si el código es correcto
    } else {
      callback(false); // Llama al callback con false si el código es incorrecto
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