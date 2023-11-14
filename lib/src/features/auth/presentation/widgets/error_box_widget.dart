import "package:flutter/material.dart";

import "../../../../core/constants/constants.dart";

class ErrorBoxWidget extends StatelessWidget {
  final String error;

  const ErrorBoxWidget({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: COLORS.errorColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Text(
            error,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
