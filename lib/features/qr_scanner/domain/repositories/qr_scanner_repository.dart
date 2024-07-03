import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class QrScannerRepository{
  Future<Either<Failure, bool>> verifiQrCode(String qrCode);
}