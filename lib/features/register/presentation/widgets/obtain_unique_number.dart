import 'dart:convert';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/cache_constants.dart';

class UniqueNumber {
  Future<int> getDeviceDetails() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String deviceIdentifier;
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceIdentifier = androidInfo.fingerprint;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor ?? "unknown";
    } else {
      throw UnsupportedError("Unsupported platform");
    }

    int result = _convertHash(deviceIdentifier);
    // guardar valor único del dispositivo en cache
    await setValue(result);

    return result;
  }

  int _convertHash(String texto) {
    // Obtener el hash del texto como número
    int hash = _hashString(texto);

    // Generar un número aleatorio basado en el hash
    Random random = Random(hash);
    int numeroAleatorio = random.nextInt(999999999);

    return numeroAleatorio;
  }

  int _hashString(String input) {
    var bytes = utf8.encode(input); // Codificar el texto en bytes
    var hash = 0;
    for (var byte in bytes) {
      hash = (31 * hash + byte) & 0xffffffff;
    }
    return hash;
  }

  Future<void> setValue(int number) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(codeCache, number);
  }

  // obtener el valor único del dispositivo de cache
  Future<int> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(codeCache);
    if (value != null) {
      return value;
    } else {
      return 0;
    }
  }
}
