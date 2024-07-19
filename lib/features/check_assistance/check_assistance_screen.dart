import '../../injection_container.dart';
import '../../router/app_routes.dart';
import '../../widgets/logo.dart';
import 'widgets/exit_app.dart';
import 'widgets/widgets.dart';
import 'package:flutter/material.dart';

class CheckAssistanceScreen extends StatefulWidget {
  final bool condition;
  const CheckAssistanceScreen({super.key, this.condition = false});

  @override
  State<CheckAssistanceScreen> createState() => _CheckAssistanceScreenState();
}

class _CheckAssistanceScreenState extends State<CheckAssistanceScreen> {
  late bool condition;

  @override
  void initState() {
    super.initState();
    condition = widget.condition; // Inicializa la variable con el valor recibido
  }

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
                  Navigator.popAndPushNamed(context, '/registerNumber');
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
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.pushNamed(context, '/notify');
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () {
                    Navigator.pushNamed(context, '/qrScanner');
                  },
                ),
              ],
            ),
            body: condition ? const CompleteCheck() : const Nocheck(),
          );
        }
      },
    );
  }
}
