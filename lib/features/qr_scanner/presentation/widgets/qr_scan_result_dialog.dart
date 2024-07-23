import 'package:flutter/material.dart';

class QrScanResultDialog extends StatefulWidget {
  final bool isScanCorrect;

  const QrScanResultDialog({super.key, required this.isScanCorrect});

  @override
  State<QrScanResultDialog> createState() => _QrScanResultDialogState();
}

class _QrScanResultDialogState extends State<QrScanResultDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _animationController.forward(from: 0.2);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return widget.isScanCorrect ? correctScanDialog() : inCorrectScanDialog();
    return correctScanDialog();
  }

  Widget correctScanDialog() {
    return AlertDialog(
      title: const Center(child: Text('Ingreso correcto')),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 200,
          ),
        ),
      ),
    );
  }

  Widget inCorrectScanDialog() {
    // final message = sl<Message>();
    return AlertDialog(
      // title: Center(child: Text(message.getMessage() ?? "QR Incorrecto")),
      title: const Center(child: Text("QR Incorrecto")),
      content: SizedBox(
        height: 225,
        child: ScaleTransition(
          scale: _animation,
          child: const Icon(
            Icons.cancel,
            color: Colors.red,
            size: 200,
          ),
        ),
      ),
    );
  }
}
