import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateToday extends StatelessWidget {
  const DateToday({super.key});

  @override
  Widget build(BuildContext context) {
    String capitalizeFirstLetter(String text) {
      return text.substring(0, 1).toUpperCase() + text.substring(1);
    }

    List<String> getCurrentDate() {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('EEEE d MMMM yyyy', 'es').format(now);
      List<String> components = formattedDate.split(' ');

      components[0] = capitalizeFirstLetter(components[0]);
      components[2] = capitalizeFirstLetter(components[2]);
      return components;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Hoy es: ${getCurrentDate()[0]} ${getCurrentDate()[1]} de ${getCurrentDate()[2]} del ${getCurrentDate()[3]}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
