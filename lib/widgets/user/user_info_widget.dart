import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hint;
  final Icon prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool autofocus;

  const CustomTextFormField({
    super.key,
    required this.hint,
    required this.prefixIcon,
    required this.onSaved,
    this.keyboardType,
    this.validator,
    this.controller,
    this.suffixIcon,
    this.focusNode,
    this.obscureText = false,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      obscuringCharacter: '●',
      cursorColor: const Color(0xFF30AF98),
      validator: validator,
      onSaved: onSaved,
      focusNode: focusNode,
      autofocus: autofocus,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFF30AF98),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFb3261e),
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: Color(0xFFb3261e),
            width: 2,
          ),
        ),
      ),
    );
  }
}
