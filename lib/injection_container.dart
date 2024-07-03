import 'package:control_asistencia_2/features/qr_scanner/domain/usecases/verify_qr_code.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/qr_scanner/data/datasource/qr_scanner_local_data_source.dart';
import 'features/qr_scanner/data/repositories/qr_scanner_repository_impl.dart';
import 'features/qr_scanner/domain/repositories/qr_scanner_repository.dart';
import 'features/qr_scanner/presentation/bloc/qr_scanner_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Qr Scanner
  // bloc
  sl.registerFactory(()
    => QrScannerBloc(
      verifyQrCode: sl(),
    )); 

  // Use Cases
  sl.registerLazySingleton(() => VerifyQrCode(repository: sl()));
    

  // Repository
  sl.registerLazySingleton<QrScannerRepository>(() 
    => QrScannerRepositoryImpl(
      localDataSource: sl()
    ));

  // Data Sources
  sl.registerLazySingleton<QrScannerLocalDataSource>(() 
    => QrScannerLocalDataSourceImpl(
      sharedPreferences: sl()
    ));

    //! Core
    
    //! External
    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);


}