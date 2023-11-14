import "package:crowdy/src/core/constants/colors.dart";
import "package:crowdy/src/core/enums/enums.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HELPERS {
  static void showSnackBar({
    required String message,
    required SnackType type,
  }) =>
      Get.showSnackbar(
        GetSnackBar(
          backgroundColor: type == SnackType.error
              ? COLORS.errorColor
              : type == SnackType.success
                  ? COLORS.successColor
                  : COLORS.warningColor,
          borderRadius: 8.0,
          duration: const Duration(seconds: 2),
          isDismissible: true,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          message: message,
          title: type.name.toUpperCase(),
          snackPosition: SnackPosition.BOTTOM,
        ),
      );

  static Widget gap({required Axis axis, double size = 24.0, int count = 1}) =>
      SizedBox(
        width: axis == Axis.horizontal ? size * count : 0,
        height: axis == Axis.vertical ? size * count : 0,
      );
}
