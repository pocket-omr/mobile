import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool withBorder;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.withBorder = false, // used in ForgotPassword
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10), // slightly less rounded
        border: withBorder
            ? Border.all(color: const Color(0xFF003E75), width: 1.2)
            : null,
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          style: const TextStyle(
            color: Color(0xFF003E75),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: const Color(0xFF003E75).withAlpha(150),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Icon(prefixIcon, color: const Color(0xFF003E75), size: 22),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 40, minHeight: 48),
            border: InputBorder.none,
            contentPadding: prefixIcon != null
                ? const EdgeInsets.symmetric(vertical: 14)
                : const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          ),
        ),
      ),
    );
  }
}