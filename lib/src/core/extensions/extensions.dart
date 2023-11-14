import "package:flutter/material.dart";

extension DateTimeX on DateTime {
  String get format => toString().substring(0, 10);
}

extension StringX on String {
  DateTime get date => DateTime(
        int.parse(substring(0, 4)),
        int.parse(substring(5, 7)),
        int.parse(substring(8, 10)),
      );
  String get capital => this[0].toUpperCase() + substring(1);
}

extension ThemeDataX on ThemeData {
  Color get color => colorScheme.inversePrimary;
}
