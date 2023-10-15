import 'package:circle/configs/custom_colors.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixWidget;
  final TextCapitalization? textCapitalization;
  final void Function()? onTap;
  final bool obscureText;
  final String hintText;
  final int? maxLines;
  final int? maxLength;

  const TextFieldWidget({
    Key? key,
    this.controller,
    this.keyboardType,
    this.suffixWidget,
    this.textCapitalization,
    this.onTap,
    this.obscureText = false,
    this.hintText = '',
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autofocus: false,
      onTap: onTap,
      maxLines: obscureText ? 1 : maxLines,
      maxLength: maxLength,
      obscureText: obscureText,
      textCapitalization: textCapitalization!,
      keyboardType: keyboardType,
      style: TextStyle(
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),
        suffix: suffixWidget,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(width: 1, color: CustomColors.olive),
        ),
      ),
    );
  }
}
