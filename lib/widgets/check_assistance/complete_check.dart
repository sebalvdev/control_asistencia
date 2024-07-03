import 'package:control_asistencia_2/widgets/date_today.dart';
import 'package:flutter/material.dart';

class CompleteCheck extends StatelessWidget {
  const CompleteCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const DateToday(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Container(
              color: Colors.green,
              child: const Text(
                'ASISTENCIA MARCADA',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
