// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit()
      : super(
            WidgetsBinding.instance.window.platformBrightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light) {
    WidgetsBinding.instance.window.onPlatformBrightnessChanged = () {
      final brightness = WidgetsBinding.instance.window.platformBrightness;
      emit(brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
    };
  }

  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }
}
