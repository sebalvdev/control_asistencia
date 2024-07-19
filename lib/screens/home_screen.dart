// ignore_for_file: use_build_context_synchronously

import 'package:control_asistencia_2/features/register/widgets/obtain_unique_number.dart';
import 'package:control_asistencia_2/widgets/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:control_asistencia_2/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UniqueNumber uniqueNumber = UniqueNumber();
  final Authenticate authenticate = Authenticate();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Titulo'),
      ),
      body: Center(
          child: ElevatedButton(
            // onPressed: () => Navigator.popAndPushNamed(context, '/firstLogin'),
            onPressed: () async {
              if(await verifyCode()) {
                Navigator.popAndPushNamed(context, '/checkAssistance');
              } else {
                Navigator.popAndPushNamed(context, '/firstLogin');
              }
            } ,
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

  Future<bool> verifyCode() async{
    int code = await uniqueNumber.getValue();
    bool verify = await authenticate.verifiCodeApi(code.toString());
    return verify;
  }
}
