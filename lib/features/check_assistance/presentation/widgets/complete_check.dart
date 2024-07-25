// import 'package:control_asistencia_2/core/api_services/find.dart';
// import 'package:control_asistencia_2/features/check_assistance/presentation/widgets/current_time.dart';
// import 'package:control_asistencia_2/widgets/location.dart';
// import 'package:control_asistencia_2/widgets/date_today.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/api_services/last_assistance.dart';
import '../../../../injection_container.dart';
import 'get_info_cache.dart';

class CompleteCheck extends StatefulWidget {
  const CompleteCheck({super.key});

  @override
  State<CompleteCheck> createState() => _CompleteCheckState();
}

class _CompleteCheckState extends State<CompleteCheck> {

  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode],
  );

  @override
  void initState() {
    super.initState();
    cameraController.stop();
  }

  @override
  Widget build(BuildContext context) {
    final lastAssistance = sl<AssistanceInfo>();
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Sobrescribir el comportamiento del botón "Regresar" para no permitir regresar
        return Future.value(false);
      },
      child: FutureBuilder<Map<String, dynamic>>(
        future: lastAssistance.fetchLastCheck(),
        builder: (context, snapshot) {
          final data = snapshot.data ?? {};
          if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData)
          {
            return SingleChildScrollView(
              child: Center(
                  child: body(data),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('No se recibieron datos'),
              ),
            );
          }
        }
      ),
    );
  }

  Widget body(Map<String, dynamic> map) {
    // final location = Location();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            '${map['type'] ?? ""} ${map['hour'] ?? ""}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.amber,
              height: 1,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          color: Colors.green,
          child: const Text(
            'ASISTENCIA MARCADA',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: getName(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(height: 240, child: getImage()),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Ubicacion: ${map['location'] ?? ""}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ),
          ],
        ),
      ],
    );
  }
}
