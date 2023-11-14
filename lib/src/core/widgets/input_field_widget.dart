import "package:flutter/material.dart";

class InputFieldWidget extends StatelessWidget {
  final void Function(String)? onChange;
  final TextEditingController? controller;
  final String? hint;
  final IconData? icon;
  final String? text;
  final bool isEnabled;
  final TextInputType? input;
  final bool isSecure;

  const InputFieldWidget({
    super.key,
    this.onChange,
    this.controller,
    this.hint,
    this.icon,
    this.text,
    this.input,
    this.isEnabled = true,
    this.isSecure = false,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextFormField(
      onChanged: onChange,
      controller: controller,
      initialValue: text,
      obscureText: isSecure,
      enabled: isEnabled,
      keyboardType: input,
      style: const TextStyle(
        fontSize: 18.0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        prefixIcon: Icon(icon, size: 32.0),
        prefixIconColor:
            isEnabled ? theme.colorScheme.inversePrimary : theme.disabledColor,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.grey.shade400,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: theme.colorScheme.inversePrimary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: theme.colorScheme.inversePrimary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: theme.colorScheme.inversePrimary,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
            color: theme.disabledColor,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
