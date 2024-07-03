import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/verify_qr_code.dart' as verify_qr_code;


part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';


class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {

  final verify_qr_code.VerifyQrCode verifyQrCode;


  QrScannerBloc({
    required this.verifyQrCode}) 
    : super(QrScannerInitial()) {
    on<VerifyQrCodeEvent>((event, emit) async {
      emit(QrScannerLoading());
      final result = await verifyQrCode(verify_qr_code.Params(qrCode: event.qrCode));
      await result.fold((failure) async => emit(QrScannerFailure()),
        (isValidQr) async => emit(QrScannerSuccess(isValidQr: isValidQr)));
    });
  }
}
