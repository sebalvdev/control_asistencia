import 'package:flutter/material.dart';

import 'package:control_asistencia_2/features/register/widgets/obtain_unique_number.dart';
import 'package:control_asistencia_2/router/app_routes.dart';
import 'package:control_asistencia_2/widgets/authenticate.dart';

class Initializer extends StatelessWidget {
  final UniqueNumber uniqueNumber = UniqueNumber();
  final Authenticate authenticate = Authenticate();

  Initializer({super.key});

  Future<bool> verifyCode() async {
    int code = await uniqueNumber.getValue();
    bool verify = await authenticate.verifiCodeApi(code.toString());
    // if(verify)
    return verify;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verifyCode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              // child: CircularProgressIndicator(),
              child: AppRoutes.loadingRout,
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (snapshot.data!) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AppRoutes.registeredRout),
              );
            } else {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AppRoutes.noRegisteredRoute),
              );
            }
          });
          return Container(); // Retorna un contenedor vacío mientras se navega
        } else {
          return const Scaffold(
            body: Center(
              child: Text('No se recibieron datos'),
            ),
          );
        }
      },
    );
  }

}