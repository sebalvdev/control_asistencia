import 'package:flutter/material.dart';

import '../../../../widgets/date_today.dart';
import 'obtain_unique_number.dart';

class Number extends StatelessWidget {
  final UniqueNumber uniqueNumber = UniqueNumber();
  Number({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const DateToday(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FutureBuilder<String>(
            // future: uniqueNumber.getDeviceDetails(),
            future: uniqueNumber.getUnique(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final number = snapshot.data!;
                return Text(
                  number.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                );
              }
            },
          ),
        ),
        const Text(
          'Número único de registro',
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}