import 'package:control_asistencia_2/features/initializer/presentation/widgets/initializer.dart';
import 'package:control_asistencia_2/features/qr_scanner/presentation/pages/qr_scanner_page.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';

class AppRoutes {
  // static const initialRout = FirstLoginScreen();
  // static const initialRout = RegisterNumberScreen();
  // static const initialRout = LoadingScreen();
  // static const initialRout = FirstLoginScreen();
  static const initialRout = CheckAssistanceScreen();
  static const noRegisteredRoute = FirstLoginScreen();
  static const registeredRout = NoCheckAssistanceScreen();
  static const loadingRout = LoadingScreen();

  static Map<String, Widget Function(BuildContext)> routes = {
    '/firstLogin': (BuildContext context) => const FirstLoginScreen(),
    '/registerNumber': (BuildContext context) => const RegisterNumberScreen(),
    '/noCheck': (BuildContext context) => const NoCheckAssistanceScreen(),
    '/notify': (BuildContext context) => const NotificationScreen(),
    '/qrScanner': (BuildContext context) => const QrScannerPage(),
    '/check': (BuildContext context) => const CheckAssistanceScreen(),

    '/initial': (BuildContext context) => Initializer(),
    '/loading': (BuildContext context) => const LoadingScreen(),

    '/alert': (BuildContext context) => const AlertScreen(),
    '/home': (BuildContext context) => HomeScreen(),
    '/test': (BuildContext context) => const TestPage(),
  };

  // ? para generar una ruta futura
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
