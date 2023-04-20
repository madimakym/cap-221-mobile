import 'package:flutter/material.dart';
import 'app_colors.dart';

class WizallTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'FuturaPTLight',
      appBarTheme: const AppBarTheme(
        elevation: 3,
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        titleTextStyle: TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontFamily: 'FuturaPTLight',
            fontWeight: FontWeight.w500),
      ),
      colorScheme: ColorScheme.fromSwatch(accentColor: const Color(0xFF13B9FF)),
      snackBarTheme:
          const SnackBarThemeData(behavior: SnackBarBehavior.floating),
      toggleableActiveColor: const Color(0xFF13B9FF),
      buttonTheme: ButtonThemeData(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
        buttonColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      dividerColor: Colors.transparent,
      // textTheme: const TextTheme(
      //   headline1: TextStyle(fontSize: 96.0),
      //   headline2: TextStyle(fontSize: 60.0),
      //   headline3: TextStyle(fontSize: 48.0),
      //   headline4: TextStyle(fontSize: 34.0),
      //   headline5: TextStyle(fontSize: 24.0),
      //   headline6: TextStyle(fontSize: 20.0),
      //   bodyText1: TextStyle(fontSize: 20.0),
      //   bodyText2: TextStyle(fontSize: 19.0),
      //   subtitle1: TextStyle(fontSize: 20.0),
      //   subtitle2: TextStyle(fontSize: 20.0),
      //   button: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      //   caption: TextStyle(fontSize: 20.0),
      //   overline: TextStyle(fontSize: 96.0),
      // ),
    );
  }
}