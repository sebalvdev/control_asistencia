part of 'qr_scanner_bloc.dart';


sealed class QrScannerEvent extends Equatable {
  const QrScannerEvent();

  @override
  List<Object> get props => [];
}

class VerifyQrCodeEvent extends QrScannerEvent {
  final String qrCode;

  const VerifyQrCodeEvent({required this.qrCode});
}
