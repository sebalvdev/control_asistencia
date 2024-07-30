import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api_services/authenticate.dart';
import 'core/api_services/find.dart';
import 'core/api_services/get_user_info.dart';
import 'core/api_services/last_assistance.dart';
import 'core/api_services/notifications.dart';
import 'core/api_services/update_signal_id.dart';
import 'features/qr_scanner/data/datasource/qr_scanner_local_data_source.dart';
import 'features/qr_scanner/data/repositories/qr_scanner_repository_impl.dart';
import 'features/qr_scanner/domain/repositories/qr_scanner_repository.dart';
import 'features/qr_scanner/domain/usecases/verify_qr_code.dart';
import 'features/qr_scanner/presentation/bloc/qr_scanner_bloc.dart';
import 'core/api_services/get_logo.dart';
import 'features/qr_scanner/presentation/widgets/snacbar.dart';

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

  //! Core - Logo

  sl.registerLazySingleton<Logo>(
    () => Logo(sharedPreferences: sl()),
  );

  //! Core - Authenticate

  sl.registerLazySingleton<Authenticate>(
    () => Authenticate(sharedPreferences: sl()),
  );

  //! Core - Notifications

  sl.registerLazySingleton<Notifications>(
    () => Notifications(sharedPreferences: sl()),
  );

  //! Core - UserInfo

  sl.registerLazySingleton<UserInfo>(
    () => UserInfo(sharedPreferences: sl()),
  );

  //! Core - UpdateSignalId

  sl.registerLazySingleton<UpdateSignalId>(
    () => UpdateSignalId(sharedPreferences: sl()),
  );

  //! Core - FindAssistance

  sl.registerLazySingleton<FindAssistance>(
    () => FindAssistance(sharedPreferences: sl()),
  );

  //! Core - Message

  sl.registerLazySingleton<Message>(
    () => Message(sharedPreferences: sl()),
  );

  //! Core - AssistanceInfo

  sl.registerLazySingleton<AssistanceInfo>(
    () => AssistanceInfo(sharedPreferences: sl()),
  );




    //! Core
    
    //! External

    final sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);


}