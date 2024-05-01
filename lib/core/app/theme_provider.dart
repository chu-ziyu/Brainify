import 'package:brainify/core/app/style_dark.dart';
import 'package:brainify/core/app/style_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(lightTheme); 

  void toggleTheme() {
    state = (state == lightTheme) ? darkTheme : lightTheme;
  }
}
