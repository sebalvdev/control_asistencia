import 'package:control_asistencia_2/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRoutes {
  static const initialRout = HomeScreen();
  // static const initialRout = CheckAssistanceScreen();
  // static const initialRout = CheckAssistanceScreen();

  static Map<String, Widget Function(BuildContext)> routes = {
    '/home': (BuildContext context) => const HomeScreen(),
    '/alert': (BuildContext context) => const AlertScreen(),
    '/loading': (BuildContext context) => const LoadingScreen(),
    '/firstLogin': (BuildContext context) => const FirstLoginScreen(),
    '/registerNumber': (BuildContext context) => const RegisterNumberScreen(),
    '/checkAssistance': (BuildContext context) => const CheckAssistanceScreen(),
    '/qrScanner': (BuildContext context) =>  const QrScannerPage(),
    '/geolocate': (BuildContext context) =>  const GeolocateScreen(),
  };

  // ? para generar una ruta futura
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
