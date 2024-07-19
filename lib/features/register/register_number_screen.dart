import 'package:control_asistencia_2/features/register/widgets/number.dart';
import 'package:flutter/material.dart';
import '../../injection_container.dart';
import '../../router/app_routes.dart';
import '../../widgets/logo.dart';
import 'widgets/exit_app.dart';

class RegisterNumberScreen extends StatefulWidget {
  const RegisterNumberScreen({super.key});

  @override
  State<RegisterNumberScreen> createState() => _RegisterNumberScreenState();
}

class _RegisterNumberScreenState extends State<RegisterNumberScreen> {
  @override
  Widget build(BuildContext context) {
    final logo = sl<Logo>();

    return FutureBuilder<String>(
      future: logo.getLogo(), // Cambiado para que sea un Future
      builder: (context, snapshot) {
        // Mientras se espera la respuesta
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              // child: CircularProgressIndicator()
              child: AppRoutes.loadingRout,
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Error loading logo')),
          );
        } else {
          String logoUrl = snapshot.data ?? 'https://default-logo-url.com/logo.jpg'; // URL predeterminada en caso de error

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/checkAssistance');
                  // exitApp();
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Image.network(
                      logoUrl,
                      fit: BoxFit.contain,
                      height: AppBar().preferredSize.height,
                    ),
                  ),
                ],
              ),
            ),
            body: Center(
              child: Number(),
            ),
          );
        }
      },
    );
  }
}
