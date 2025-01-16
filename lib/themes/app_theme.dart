import 'package:flutter/material.dart';
import 'package:lomfu_app/themes/colors.dart';

class AppTheme {
  // Light Theme
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightSurface,
    shadowColor: AppColors.black,
    appBarTheme: AppBarTheme(
      color: AppColors.lightPrimary,
      iconTheme: IconThemeData(color: AppColors.lightText),
      titleTextStyle: TextStyle(
        color: AppColors.lightText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: AppColors.lightText, fontSize: 16),
      labelMedium: TextStyle(color: AppColors.lightSurface, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.lightText, fontSize: 12),
      titleLarge: TextStyle(
        color: AppColors.lightText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: AppColors.lightText, fontSize: 16),
      titleSmall: TextStyle(color: AppColors.lightText, fontSize: 12),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightPrimary,
        foregroundColor: AppColors.white,
        textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightSurface,
      selectedItemColor: AppColors.lightText,
      unselectedItemColor: AppColors.lightPrimary,
    ),
  );

  // Dark Theme
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface,
    shadowColor: AppColors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.darkPrimary,
      iconTheme: IconThemeData(color: AppColors.darkText),
      titleTextStyle: TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      labelLarge: TextStyle(color: AppColors.darkText, fontSize: 16),
      labelMedium: TextStyle(color: AppColors.darkSurface, fontSize: 14),
      labelSmall: TextStyle(color: AppColors.darkSurface, fontSize: 12),
      titleLarge: TextStyle(
        color: AppColors.darkText,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(color: AppColors.darkSurface, fontSize: 16),
      titleSmall: TextStyle(color: AppColors.darkSurface, fontSize: 12),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.darkPrimary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.white,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColors.lightText),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.darkPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,
      selectedItemColor: AppColors.darkPrimary,
      unselectedItemColor: AppColors.darkText,
    ),
  );
}
