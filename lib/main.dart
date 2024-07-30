import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:control_asistencia_qr/features/initializer/presentation/widgets/initializer.dart';
import 'package:control_asistencia_qr/router/app_routes.dart';
import 'package:control_asistencia_qr/theme_cubit.dart';
import 'package:control_asistencia_qr/themes/app_theme.dart';

import 'injection_container.dart' as dependencies;
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es', null);
  await Geolocator.requestPermission();
  await dependencies.init();

  runApp(
    BlocProvider(
      create: (_) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        // const condition = false;

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Main',

          home: Initializer(sharedPreferences: sl(),),
          // home: AppRoutes.initialRout,
          routes: AppRoutes.routes,
          // ? para generar una ruta futura
          onGenerateRoute: AppRoutes.onGenerateRoute,

          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
        );
      },
    );
  }
}
