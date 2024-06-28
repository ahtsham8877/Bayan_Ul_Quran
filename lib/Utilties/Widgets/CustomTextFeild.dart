import 'package:bayanulquran/Utilties/Fonts/Fonts.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final void Function(String)? onChanged;
  final String? text;
  final double? height;
  final double? width;
  final double? textSize;
  final Color? textColor;
  final String? validateText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double? borderRadius;
  final double? bottomPadding;
  final String? hintText;
  final void Function(String)? onSubbmitted; // Added type for onSubmitted
  final EdgeInsetsGeometry? padding; // Add a new parameter for padding

  CustomTextField({
    this.labelText,
    this.controller,
    this.onSubbmitted,
    this.hintText,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.text,
    this.height = 48,
    this.width,
    this.textSize = 14,
    this.textColor = const Color.fromARGB(158, 0, 0, 0),
    this.validateText,
    this.prefixIcon,
    this.suffixIcon,
    this.borderRadius = 8,
    this.bottomPadding = 16.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(bottom: bottomPadding!),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        onFieldSubmitted: onSubbmitted,
        style: TextStyle(color: Colors.white, fontFamily: mainfont),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: mainfont,
          ),
          filled: true,
          fillColor: Color.fromARGB(204, 141, 110, 69),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return validateText;
          }
          return null;
        },
      ),
    );
  }
}
