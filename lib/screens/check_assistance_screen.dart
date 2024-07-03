import '../widgets/check_assistance/widgets.dart';
import 'package:flutter/material.dart';

class CheckAssistanceScreen extends StatefulWidget {
  const CheckAssistanceScreen({super.key});

  @override
  State<CheckAssistanceScreen> createState() => _CheckAssistanceScreenState();
}

class _CheckAssistanceScreenState extends State<CheckAssistanceScreen> {
  bool condition = true; 

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
                child: Image.asset('assets/images/game.jpeg', // Ruta de tu logo
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
              icon: const Icon(Icons.replay),
              onPressed: () {
                // Acción para el botón de ajustes
              },
            ),
          ],
        ),
        body: condition ? const CompleteCheck() : const Nocheck(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/qrScanner');
          },
          backgroundColor: Colors.grey,
          child: const Icon(Icons.camera_alt_outlined, color: Color.fromARGB(255, 255, 255, 255),),
        ));
  }
}
