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
          // const SizedBox(height: 50,),
          const Padding(
            padding: EdgeInsets.all(60.0),
            child: CircularProgressIndicator(),
          ),
          // const SizedBox(height: 50,),

          // Image.asset(
          //   'assets/images/loading.gif',
          //   // scale: 2,
          // ),

          ElevatedButton(
            onPressed: () {},
            // onPressed: () => Navigator.popAndPushNamed(context, '/firstLogin'),
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
