import 'package:control_asistencia_2/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';

import '../screens/screens.dart';

class AppRoutes {
  // static const initialRout = FirstLoginScreen();
  static const initialRout = NotificationScreen();
  // static const initialRout = TestScreen();
  // static const initialRout = CheckAssistanceScreen();
  static const noRegisteredRoute = FirstLoginScreen();
  static const registeredRout = CheckAssistanceScreen();
  static const loadingRout = LoadingScreen();

  static Map<String, Widget Function(BuildContext)> routes = {
    '/home': (BuildContext context) => HomeScreen(),
    '/alert': (BuildContext context) => const AlertScreen(),
    '/loading': (BuildContext context) => const LoadingScreen(),
    '/firstLogin': (BuildContext context) => const FirstLoginScreen(),
    '/registerNumber': (BuildContext context) => const RegisterNumberScreen(),
    '/checkAssistance': (BuildContext context) => const CheckAssistanceScreen(),
    '/qrScanner': (BuildContext context) => const QrScannerPage(),
    '/notify': (BuildContext context) => const NotificationScreen(),
    '/test': (BuildContext context) => const TestScreen(),
  };

  // ? para generar una ruta futura
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
