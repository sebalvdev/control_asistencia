import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../bloc/qr_scanner_bloc.dart';
import '../../../../injection_container.dart';
import '../widgets/qr_scan_result_dialog.dart';
import '../widgets/widgets.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  
  bool isLoading = false;
  bool isSuccess = false;
  
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    formats: [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Acceso'),
        // actions: [IconButton(onPressed: () => cameraController.toggleTorch(), icon: const Icon(Icons.flash_on))],
      ),
      // body: buildBody(cameraController: cameraController),
      body: buildBodym(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () => cameraController.toggleTorch(),
          child: const Icon(Icons.flash_on),
        )
    );
  }

  BlocProvider<QrScannerBloc> buildBodym(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<QrScannerBloc>(),
        child: Center(
          child: Padding(
          padding: const EdgeInsets.all(10),
            child: BlocBuilder<QrScannerBloc, QrScannerState>(
            builder: (context, state) {
              if (state is QrScannerLoading) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                setState(() {
                  isLoading = true;
                });
              });
            }
            if (state is QrScannerSuccess) {
              isSuccess = true;
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                setState(() {
                  isLoading = false;
                });
                await scannedQrDialog(context, state.isValidQr);
              });
            }

            return MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                var qrCapture = capture.barcodes[0];
                BlocProvider.of<QrScannerBloc>(context).add(
                    VerifyQrCodeEvent(
                        qrCode: qrCapture.displayValue ?? ''));
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
          }),
        )));
  }

  scannedQrDialog(BuildContext context, isCorrect) async {
    final player = AudioPlayer();
    if(isCorrect) {
      await player.play(AssetSource("audio/sound.mp3"));
    } else {
      await player.play(AssetSource("audio/sound.mp3"));
    }
    await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) =>
            QrScanResultDialog(isScanCorrect: isCorrect)).then((_) {
        isSuccess = false;
      });
    }

  BlocProvider<QrScannerBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<QrScannerBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MobileScanner(
              controller: cameraController,
              onDetect: (capture) {
                var qrCapture = capture.barcodes[0];
                BlocProvider.of<QrScannerBloc>(context).add(
                    VerifyQrCodeEvent(
                        qrCode: qrCapture.displayValue ?? ''));
              },
              overlay: Container(
                decoration: ShapeDecoration(
                  shape: QrScannerViewer(
                    borderColor: Colors.white,
                    borderRadius: 10,
                    borderLength: 10,
                    borderWidth: 5,
                    cutOutSize: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
              ),
            ),
          ),
        )
      );
    }
  }

