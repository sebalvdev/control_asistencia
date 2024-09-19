// ignore_for_file: use_build_context_synchronously

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../injection_container.dart';
import '../bloc/qr_scanner_bloc.dart';
import '../widgets/widgets.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  bool isLoading = false;
  bool isScanEnabled = true;
  bool isSuccess = false;

  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode],
  );

  @override
  void dispose() {
    // Asegúrate de detener la cámara al cerrar el widget
    // cameraController.dispose();
    cameraController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de acceso'),
        actions: [appBarTorch()],
      ),
      body: buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () => cameraController.toggleTorch(),
        child: const Icon(Icons.flash_on),
      ),
    );
  }

  BlocProvider<QrScannerBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<QrScannerBloc>(),
      child: BlocConsumer<QrScannerBloc, QrScannerState>(
        listener: (context, state) async {
          if (state is QrScannerLoading && !isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              setState(() {
                isLoading = true;
              });
            });
          }

          if (state is QrScannerSuccess && !isSuccess) {
            isSuccess = true;
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              setState(() {
                isLoading = false;
              });
              await scannedQRDialog(context, state.isValidQr);
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  if (isScanEnabled) {
                    setState(() {
                      isScanEnabled = false;
                    });
                    var qrCapture = capture.barcodes[0];
                    BlocProvider.of<QrScannerBloc>(context).add(
                      VerifyQrCodeEvent(qrCode: qrCapture.displayValue ?? ''),
                    );
                  }
                },
                overlay: Container(
                  decoration: ShapeDecoration(
                    shape: QrScannerOverlayShape(
                      borderColor: Colors.white,
                      borderRadius: 10,
                      borderLength: 25,
                      borderWidth: 7.5,
                      cutOutSize: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 60.0,
                          width: 60.0,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Analizando pase de acceso...',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Future<void> scannedQRDialog(BuildContext context, bool isScanCorrect) async {
  final player = AudioPlayer();
  await player.play(AssetSource("audio/sound.mp3"));
  if (isScanCorrect) {
    await showDialog(
      context: context,
      builder: (BuildContext context) =>
          QrScanResultDialog(isScanCorrect: isScanCorrect),
    ).then((_) async {
      isScanEnabled = true;
      isSuccess = false;
    });
    
    // Aquí se redirige automáticamente sin esperar que el usuario cierre el diálogo
    if (mounted) {
      await Navigator.pushNamed(context, '/check');
    }
  } else {
    final message = sl<Message>();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(message.snackBar());
      setState(() {
        isScanEnabled = true;
        isSuccess = false;
      });
    }
  }
}


  IconButton appBarTorch() {
    return IconButton(
      onPressed: () => cameraController.toggleTorch(),
      color: Colors.white,
      iconSize: 32.0,
      icon: ValueListenableBuilder(
        valueListenable: cameraController.torchState,
        builder: (context, state, child) {
          switch (state) {
            case TorchState.off:
              return const Icon(Icons.flash_off, color: Colors.grey);
            case TorchState.on:
              return const Icon(Icons.flash_on, color: Colors.yellow);
          }
        },
      ),
    );
  }
}
