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
  );
}
