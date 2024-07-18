import 'dart:math';

class InLocation {
  final double latitude;
  final double longitude;

  InLocation(this.latitude, this.longitude);
}

class DistanceCalculator {
  // Radio de la Tierra en metros
  static const double _earthRadiusKm = 6378.0;

  static double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static double _haversineDistance(InLocation loc1, InLocation loc2) {
    final double lat1 = _degreesToRadians(loc1.latitude);
    final double lon1 = _degreesToRadians(loc1.longitude);
    final double lat2 = _degreesToRadians(loc2.latitude);
    final double lon2 = _degreesToRadians(loc2.longitude);

    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;

    final double a = pow(sin(dLat / 2), 2) +
        cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return _earthRadiusKm * c;
  }

  static bool isWithin100Meters(InLocation loc1, InLocation loc2) {
    // Distancia en kilómetros
    final double distanceKm = _haversineDistance(loc1, loc2);
    // Convertir la distancia a metros
    final double distanceMeters = distanceKm * 1000;
    // Comprobar si la distancia es menor o igual a 100 metros
    return distanceMeters <= 100;
  }
}

// void main() {
//   final loc1 = InLocation(37.7749295, -122.4194155); // Coordenadas con 7 decimales
//   final loc2 = InLocation(37.77492950000000, -122.41941550000000); // Coordenadas con 14 decimales

//   bool isClose = DistanceCalculator.isWithin100Meters(loc1, loc2);

//   print('La ubicación está dentro de 100 metros: $isClose');
// }
