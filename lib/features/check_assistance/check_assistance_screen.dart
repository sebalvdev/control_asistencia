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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              //! Acción para salir de la aplicación
              Navigator.popAndPushNamed(context, '/registerNumber');
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset('assets/images/logo.jpg',
                    fit: BoxFit.contain,
                    height: AppBar().preferredSize.height),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                // Acción para el botón de búsqueda
              },
            ),
            IconButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () {
                // Acción para el botón de ajustes
                Navigator.pushNamed(context, '/qrScanner');
              },
            ),
          ],
        ),
        body: condition ? const CompleteCheck() : const Nocheck(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/qrScanner');
        //   },
        //   child: const Icon(Icons.camera_alt_outlined),
        // )
    );
  }
}
