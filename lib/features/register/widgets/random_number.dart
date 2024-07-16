import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/cache_constants.dart';
import '../../../widgets/date_today.dart';

class RandomNumber extends StatefulWidget {
  const RandomNumber({super.key});

  @override
  State<RandomNumber> createState() => _RandomNumberState();
}

class _RandomNumberState extends State<RandomNumber> {
  late Future<int> futureNumber;

  @override
  void initState() {
    super.initState();
    startTimer();
    futureNumber = getValue();
  }

  @override
  void dispose() {
    super.dispose();
    // Cancelar el temporizador al salir del widget
    timer?.cancel();
  }

  Timer? timer;

  void startTimer() {
    // timer = Timer.periodic(const Duration(minutes: 2), (timer) {
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setValue();
    });
  }

  Future<void> setValue() async {
    final newNumber = Random().nextInt(888888888) + 111111111;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(codeCache, newNumber);
    // Actualizar futureNumber solo si el widget está montado
    // ignore: avoid_print
    print(newNumber);
    if (mounted) {
      setState(() {
        futureNumber = getValue();
      });
    }
  }

  Future<int> getValue() async {
    final prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(codeCache);
    if(value != null) {
      return value;
    } else {
      setValue();
    }
    return getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const DateToday(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: FutureBuilder<int>(
            future: futureNumber,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                int number = snapshot.data!;
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
