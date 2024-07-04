import 'package:control_asistencia_2/widgets/check_assistance/current_time.dart';
import 'package:control_asistencia_2/widgets/geolocator/location.dart';
// import 'package:control_asistencia_2/widgets/date_today.dart';
import 'package:flutter/material.dart';

class CompleteCheck extends StatefulWidget {
  const CompleteCheck({super.key});

  @override
  State<CompleteCheck> createState() => _CompleteCheckState();
}

class _CompleteCheckState extends State<CompleteCheck> {
  String currentTime = '';

  @override
  void initState() {
    super.initState();
    // updateTime();
    currentTime = CurretTime.getCurrentTime();
  }

  // void updateTime() {
  //   setState(() {
  //     currentTime = CurretTime.getCurrentTime();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // const DateToday(),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Ingreso: $currentTime',
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
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Sebastian Alvarez',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/images/icono.jpeg',
                    scale: 2,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Location(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
