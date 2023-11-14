import "package:crowdy/src/core/constants/constants.dart";
import "package:flutter/material.dart";

class THEMES {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: COLORS.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: COLORS.white,
    useMaterial3: true,
    fontFamily: "Hermit",
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: const StadiumBorder(
          side: BorderSide(width: 0.75),
        ),
        foregroundColor: ColorScheme.fromSeed(
          seedColor: COLORS.primary,
          brightness: Brightness.light,
        ).inversePrimary,
      ),
    ),
  );
}
