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
          Image.asset(
            'assets/images/icono.jpeg',
            scale: 2,
          ),

          Image.asset(
            'assets/images/loading.gif',
            // scale: 2,
          ),

          ElevatedButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/firstLogin'),
            child: Image.asset(
              'assets/images/icono.jpeg',
              scale: 4,
            ),
          ),
          
        ],
      ),
    ));
  }
}
