import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/qr_scanner_repository.dart';

class VerifyQrCode implements UseCase<bool,Params>{
  final QrScannerRepository repository;

  VerifyQrCode({required this.repository});
  
  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.verifiQrCode(params.qrCode);
  }
  
}

class Params extends Equatable {
  final String qrCode;

  const Params({required this.qrCode});


  @override
  List<Object?> get props => [qrCode];
}