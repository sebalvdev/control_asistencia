import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../bloc/qr_scanner_bloc.dart';
import '../../../../injection_container.dart';
import '../widgets/widgets.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode],
  );

  bool isProcessing = false; // Flag to prevent multiple verifications
  bool isDialogOpen = false; // Flag to prevent multiple dialogs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Acceso'),
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
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<QrScannerBloc, QrScannerState>(
            builder: (context, state) {
              if (state is QrScannerLoading) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (mounted) {
                    setState(() {});
                  }
                });
              }
              if (state is QrScannerSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  if (!isDialogOpen) {
                    isDialogOpen = true;
                    await cameraController.stop();
                    // ignore: use_build_context_synchronously
                    await scannedQrDialog(context, state.isValidQr);
                    if (mounted) {
                      await cameraController.start();
                      setState(() {
                        isProcessing = false; // Reset the flag after processing
                      });
                    }
                    isDialogOpen = false;
                  }
                });
              }

              return MobileScanner(
                controller: cameraController,
                onDetect: (capture) {
                  if (!isProcessing) {
                    setState(() {
                      isProcessing = true; // Set the flag when processing starts
                    });
                    var qrCapture = capture.barcodes[0];
                    BlocProvider.of<QrScannerBloc>(context).add(
                      VerifyQrCodeEvent(qrCode: qrCapture.displayValue ?? ''),
                    );
                  }
                },
                overlay: Container(
                  decoration: ShapeDecoration(
                    shape: QrScannerViewer(
                      borderColor: Colors.white,
                      borderRadius: 10,
                      borderLength: 25,
                      borderWidth: 7.5,
                      cutOutSize: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> scannedQrDialog(BuildContext context, bool isCorrect) async {
    final player = AudioPlayer();
    if (isCorrect) {
      await player.play(AssetSource("audio/sound.mp3"));
      await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) =>
            QrScanResultDialog(isScanCorrect: isCorrect),
      ).then((_) async {
        if (mounted) {
          isDialogOpen = false; // Reset dialog flag before navigation
          await Navigator.pushNamed(context, '/check');
        }
      });
    } else {
      final message = sl<Message>();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(message.snackBar());
        isDialogOpen = false; // Reset dialog flag after showing snackbar
      }
    }
  }
}
