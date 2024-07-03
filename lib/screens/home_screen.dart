import 'package:flutter/material.dart';
import 'package:control_asistencia_2/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titulo'),
      ),
      body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.popAndPushNamed(context, '/loading'), 
            child: const Text('Start')
            )),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              child: const Icon(Icons.sunny),
            ),
    );
  }
}
