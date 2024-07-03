import 'package:flutter/material.dart';

class QRScannerMessage extends StatefulWidget {
  const QRScannerMessage({super.key, required this.isCorrect});
  final bool isCorrect;

  @override
  State<QRScannerMessage> createState() => _QRScannerMessageState();
}

class _QRScannerMessageState extends State<QRScannerMessage>
  with SingleTickerProviderStateMixin {

    @override
    Widget build(BuildContext context) {
      return widget.isCorrect ? correctScanDialog() : inCorrectScanDialog();
    }
    Widget correctScanDialog() {
      return const AlertDialog(
        title: Center(child: Text('QR correcto')),
        content: SizedBox(
        height: 150,
        child: Icon(
            Icons.check_circle_outlined,
            color: Colors.green,
            size: 100,
          ),
        ),
      );
    }
    Widget inCorrectScanDialog() {
      return const AlertDialog(
        title: Center(child: Text('QR incorrecto')),
        content: SizedBox(
          height: 150,
          child: Icon(
            Icons.cancel_outlined,
            color: Colors.red,
            size: 100,
          ),
        ),
      );
    }
}