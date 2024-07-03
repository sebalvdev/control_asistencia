import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/qr_scanner_repository.dart';
import '../datasource/qr_scanner_local_data_source.dart';

class QrScannerRepositoryImpl implements QrScannerRepository {
  final QrScannerLocalDataSource localDataSource;

  QrScannerRepositoryImpl({
    required this.localDataSource
  });
  
  @override
  Future<Either<Failure, bool>> verifiQrCode(String serial) async{
    try{
      final result = await localDataSource.verifiQrCode(serial);
      return Future.value((right(result)));
    } on CacheFailure {
      return Future.value(left(CacheFailure()));
    } on UnkownFailure {
      return Future.value(left(UnkownFailure()));
    }
  }
}