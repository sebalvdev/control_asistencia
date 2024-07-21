import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/cache_constants.dart';

class Authenticate {
  
  Future<bool> verifiCodeApi(String codeVerification) async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(serverCache);

    if(code == null){
      return false;
    }
    
    String key = "https://jcvctechnology.com/$code/api/api.php";
    final operation = "?authenticate=$codeVerification";
    final url = Uri.parse(key + operation);
    final response = await http.get(url);

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