import 'package:control_asistencia_2/data/remotedatasource.dart';
import 'package:flutter/material.dart';

class FirstLoginScreen extends StatelessWidget {
  const FirstLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Remotedatasource remotedatasource = Remotedatasource();

    void verificarCodigo() {
    remotedatasource.verificar(controller.text, (esCorrecto) {
      if (!esCorrecto) {
        const snackBar = SnackBar(
          content: Text('No se pudo conectar con ningun servidor'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        );
        
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        Navigator.popAndPushNamed(context, '/registerNumber');
      }
    });
  }

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Acceso',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Solo personal autorizado',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  'assets/images/icono.jpeg',
                  scale: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // color: Colors.grey,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10.0),
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.home),
                        labelText: 'Acceso',
                        border: InputBorder.none,
                        suffixIcon: TextButton(
                          // ignore: avoid_print
                          onPressed: verificarCodigo,
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.green),
                          child: const Text(
                            'conectar',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
