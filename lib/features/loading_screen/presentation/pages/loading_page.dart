import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Image.asset(
              'assets/images/icono_sin.png',
              scale: 2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(60.0),
            child: CircularProgressIndicator(),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Image.asset(
              'assets/images/logo.jpg',
              scale: 4,
            ),
          ),
        ],
      ),
    ));
  }
}
