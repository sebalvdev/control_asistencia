import 'package:control_asistencia_2/core/api_services/find.dart';
// import 'package:control_asistencia_2/features/check_assistance/presentation/widgets/current_time.dart';
// import 'package:control_asistencia_2/widgets/location.dart';
// import 'package:control_asistencia_2/widgets/date_today.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import 'get_info_cache.dart';
// import 'location.dart';

class CompleteCheck extends StatefulWidget {
  const CompleteCheck({super.key});

  @override
  State<CompleteCheck> createState() => _CompleteCheckState();
}

class _CompleteCheckState extends State<CompleteCheck> {
  // String currentTime = '';

  @override
  void initState() {
    super.initState();
    // updateTime();
    // currentTime = CurretTime.getCurrentTime();
  }

  @override
  Widget build(BuildContext context) {
    final find = sl<FindAssistance>();
    return SingleChildScrollView(
      child: Center(
        child: FutureBuilder(
          future: find.findAssistance(qrCode: "2310940139765262"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading logo'));
            } else {
              if(snapshot.data?['success']) {
                return body(snapshot.data ?? {});
              } else {
                return Text('Error: ${snapshot.data?['message']}');
              }
            }
          },
        ),
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
            '${map['type_asistence']} ${map['date']}',
            // 'Ingreso: $currentTime',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.amber,
              height: 1,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        (map['type_asistence'] == 'Ingreso') ?
        Container(
          color: Colors.green,
          child: const Text(
            'ASISTENCIA MARCADA',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
        :
        Container(
          color: Colors.green,
          child: const Text(
            'SALIDA MARCADA',
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
                'Ubicacion: ${map['registration']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
              // child: FutureBuilder(
              //   future: location.getPosition(),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (snapshot.hasError) {
              //       return const Center(child: Text('Error loading logo'));
              //     } else {
              //       return snapshot.data ?? const SizedBox();
              //     }
              //   },
              // ),
            ),
          ],
        ),
      ],
    );
  }
}
