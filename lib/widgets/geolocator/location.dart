import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  // String _locationMessage = "Ubicación:";

  @override
  void initState() {
    super.initState();
    // determinePosition();
  }

  Future<String> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // setState(() {
      // _locationMessage = 'Los servicios de ubicación están deshabilitados';
      return 'Los servicios de ubicación están deshabilitados';
      // });
      // return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // setState(() {
        // _locationMessage = 'Se deniegan los permisos de ubicación';
        return 'Se deniegan los permisos de ubicación';
        // });
        // return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // setState(() {
      return 'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos';
      // });
      // return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      // setState(() {
      // _locationMessage =
      return 'Ubicación: ${position.latitude}, ${position.longitude}';
      // });
    } catch (e) {
      // setState(() {
      // _locationMessage = 'Error: $e';
      return 'Error: $e';
      // });
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
