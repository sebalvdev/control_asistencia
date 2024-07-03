import 'package:control_asistencia_2/widgets/register_number/number.dart';
import 'package:flutter/material.dart';


class RegisterNumberScreen extends StatefulWidget {
  const RegisterNumberScreen({super.key});

  @override
  State<RegisterNumberScreen> createState() => _RegisterNumberScreenState();
}

class _RegisterNumberScreenState extends State<RegisterNumberScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              //! Acción para salir de la aplicación
              Navigator.popAndPushNamed(context, '/checkAssistance');
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
              icon: const Icon(Icons.replay),
              onPressed: () {
                // Acción para el botón de ajustes
                setState(() {});
              },
            ),
          ],
        ),
        body: const Center(
          child: Number(),
        )
        );
  }
}
