// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Locationppp extends StatefulWidget {
  const Locationppp({super.key});

  @override
  State<Locationppp> createState() => _LocationState();
}

class _LocationState extends State<Locationppp> {
  // String _locationMessage = "Ubicación:";

  @override
  void initState() {
    super.initState();
    // determinePosition();
  }

  Future<String> determinePosition() async {
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

    try {
      Position position = await Geolocator.getCurrentPosition();
      print("latitude: ${position.latitude}");
      print("longitude: ${position.longitude}");
      return 'Ubicación: ${position.latitude}, ${position.longitude}';
    } catch (e) {
      print('Error: $e');
      return 'Error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: determinePosition(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'
          );
        } else {
          return Text(
              'Result: ${snapshot.data}'
          );
        }
      },
    );
  }
}
