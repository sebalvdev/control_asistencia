import 'package:control_asistencia_2/router/app_routes.dart';
import 'package:control_asistencia_2/theme_cubit.dart';
import 'package:control_asistencia_2/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'injection_container.dart' as dependencies;

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Main',
          home: AppRoutes.initialRout,
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
