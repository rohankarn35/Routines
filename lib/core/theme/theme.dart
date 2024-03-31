import 'package:flutter/material.dart';
import 'package:routines/core/theme/app_pallete.dart';

class AppTheme{
  static final darkThemeMode = ThemeData.dark().copyWith( 
    scaffoldBackgroundColor: AppPallete.backgroundColor
  );
}