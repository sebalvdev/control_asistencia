import 'package:control_asistencia_qr/features/check_assistance/presentation/widgets/last_assistance_check.dart';
import 'package:control_asistencia_qr/features/check_assistance/presentation/widgets/widgets.dart';
import 'package:control_asistencia_qr/widgets/date_today.dart';
import 'package:flutter/material.dart';

class Nocheck extends StatelessWidget {
  const Nocheck({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: DateToday(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                color: Colors.red,
                child: const Text(
                  'ASISTENCIA NO MARCADA',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: getName(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                height: 240,
                child: getImage()
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: LastAssistanceCheck(),
            ),
          ],
        ),
      ),
    );
  }
}
