// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  Future<String> determinePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Los servicios de ubicación están deshabilitados';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Se deniegan los permisos de ubicación';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return 'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos';
    }

    return "";
  }

  Future<String> getLatitude() async {
    final error = await determinePermission();
    if (error == "") {
      try {
        Position position = await Geolocator.getCurrentPosition();
        return '${position.latitude}';
      } catch (e) {
        print('Error: $e');
        return 'Error: $e';
      }
    } else {
      return error;
    }
  }

  Future<String> getLongitude() async {
    final error = await determinePermission();
    if (error == "") {
      try {
        Position position = await Geolocator.getCurrentPosition();
        return '${position.longitude}';
      } catch (e) {
        print('Error: $e');
        return 'Error: $e';
      }
    } else {
      return error;
    }
  }

  Future<Widget> getPosition() async {
    final latitude = await getLatitude();
    final longitude = await getLongitude();
    print('Ubicacion: $latitude, $longitude');
    return Text('Ubicacion: $latitude, $longitude');
  }
}