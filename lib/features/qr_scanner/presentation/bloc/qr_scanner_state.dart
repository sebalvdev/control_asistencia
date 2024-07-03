part of 'qr_scanner_bloc.dart';

sealed class QrScannerState extends Equatable {
  const QrScannerState();
  
  @override
  List<Object> get props => [];
}

final class QrScannerInitial extends QrScannerState {}

final class QrScannerLoading extends QrScannerState {}

final class QrScannerSuccess extends QrScannerState {
  final bool isValidQr;

  const QrScannerSuccess({required this.isValidQr});
}

final class QrScannerFailure extends QrScannerState {}
