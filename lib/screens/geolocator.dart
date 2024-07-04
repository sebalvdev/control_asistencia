import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocateScreen extends StatefulWidget {
  const GeolocateScreen({super.key});

  @override
  State<GeolocateScreen> createState() => _GeolocateScreenState();
}

class _GeolocateScreenState extends State<GeolocateScreen> {
  String _locationMessage = "Ubicación:";
  double latitude = -17.3888350;
  double longitude = -66.1184550;
  double latit = 0;
  double longit = 0;

  @override
  void initState() {
    super.initState();
    determinePosition();
    // getPosition();
    // comparePosition();
  }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Los servicios de ubicación están deshabilitados';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Se deniegan los permisos de ubicación';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage =
            'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos';
      });
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _locationMessage =
            'Ubicación: ${position.latitude}, ${position.longitude}';
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: $e';
      });
    }
  }

  Future<void> getPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition();
      latit = position.latitude;
      longit = position.longitude;
    } catch (e) {
      setState(() {
        // ignore: avoid_print
        print('Error: $e');
      });
    }
  }

  bool inArea({
    required double centerLatitude,
    required double centerLongitude,
    required double radiusInMeters,
    required double targetLatitude,
    required double targetLongitude,
  }) {
    double distance = Geolocator.distanceBetween(
      centerLatitude,
      centerLongitude,
      targetLatitude,
      targetLongitude,
    );

    return distance <= radiusInMeters;
  }

  void comparePosition() {
    // getPosition();
    final result = inArea(
      centerLatitude: latit,
      centerLongitude: longit,
      radiusInMeters: 100000,
      targetLatitude: latit,
      targetLongitude: longit,
    );
    if (result) {
      setState(() {
        _locationMessage = 'Ubicacion correcta';
      });
    } else {
      setState(() {
        _locationMessage = 'Ubicacion incorrecta';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Titulo'),
        ),
        body: Center(
          child: Text(_locationMessage),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async => determinePosition,
        )
      );
  }
}
