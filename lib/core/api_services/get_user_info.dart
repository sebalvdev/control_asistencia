// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';
import '../constants/domain.dart';

class UserInfo {

  final SharedPreferences sharedPreferences;

  UserInfo({required this.sharedPreferences});

  Future<void> getUserInfo() async {
    final code = sharedPreferences.getString(serverCache);
    final codeVerification = sharedPreferences.getString(codeCache);

    // String key = "https://jcvctechnology.com/$code/api/api.php";
    String key = "https://$domainName/$code/api/api.php";
    final operation = "?get_user_info=$codeVerification";
    final url = Uri.parse(key + operation);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        if (data['success']) {
          await sharedPreferences.setString(userInfoCache, json.encode(data));
          // print('Datos guardados en SharedPreferences');
        } else {
          print('Error: ${data['error']}');
        }
      } else {
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String?> getName() async {
    String? userInfo = sharedPreferences.getString(userInfoCache);

    if (userInfo != null) {
      final map = json.decode(userInfo);
      return '${map['name_user']} ${map['lastname_user']}';
    } else {
      return "nombre";
    }
  }

  Future<String?> getImage() async {
    String? userInfo = sharedPreferences.getString(userInfoCache);
    final code = sharedPreferences.getString(serverCache);
    if (userInfo != null) {
      final map = json.decode(userInfo);
      final url = "https://$domainName/$code/images/users/${map['image_user']}";
      return url;
    }
    return null;
  }

  Future<String?> getUserId() async {
    String? userInfo = sharedPreferences.getString(userInfoCache);

    if (userInfo != null) {
      final map = json.decode(userInfo);
      return map['id_user'];
    } else {
      return "id";
    }
  }
}

