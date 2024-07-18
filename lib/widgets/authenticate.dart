import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constants/cache_constants.dart';

class Authenticate {
  
  Future<bool> getData(String codeVerification) async {
    String key = "https://jcvctechnology.com/asistenciaonline/api/";
    String filename = "authenticate.php";
    final url = Uri.parse(key + filename);

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'code_verification': codeVerification,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData) {
        //? : Positive response
        setValue(true);
        return true;
      } else {
        //? : Negative response
        return false;
      }
    } else {
      throw Exception('Failed to authenticate');
    }
  }

  Future<void> setValue(bool state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(stateAccountCache, state);
  }

  Future<bool> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(stateAccountCache);
    if(value != null) {
      return value;
    } else {
      return false;
    }
  }
}