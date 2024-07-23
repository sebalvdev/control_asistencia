// ignore_for_file: use_build_context_synchronously

import 'package:control_asistencia_2/features/register/presentation/widgets/obtain_unique_number.dart';
import 'package:control_asistencia_2/core/api_services/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:control_asistencia_2/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class HomeScreen extends StatelessWidget {
  final UniqueNumber uniqueNumber = UniqueNumber();

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
    final Authenticate authenticate = sl();
    int code = await uniqueNumber.getValue();
    bool verify = await authenticate.verifiCodeApi(code.toString());
    return verify;
  }
}
