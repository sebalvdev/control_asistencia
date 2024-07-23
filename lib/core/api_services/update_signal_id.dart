// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../injection_container.dart';
import '../constants/cache_constants.dart';
import './api.dart';

class UpdateSignalId {

  final SharedPreferences sharedPreferences;

  UpdateSignalId({required this.sharedPreferences});

  Future<void> updateOneSignalId() async {
    final userInfo = sl<UserInfo>();

    final isAndroid = Platform.isAndroid ? 0 : 1;
    const oneSignal = '2c166916-fb46-4896-8e52-d60ea6b7fee7';
    final userId = await userInfo.getUserId();
    final code = sharedPreferences.getString(serverCache);

    final response = await http.get(
      Uri.parse('https://jcvctechnology.com/$code/api/api.php?new_signal_id=$oneSignal&user_id=$userId&ios=$isAndroid'),
      headers: {"Content-Type": "application/json"},
    );

    try {
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success']) {
          // Actualización exitosa
          print('ID de OneSignal actualizado: ${data['onesignal_id']}');
        } else {
          print('Message: $data');
        }
      } else {
        // Error en la solicitud
        print('Error en la solicitud: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
