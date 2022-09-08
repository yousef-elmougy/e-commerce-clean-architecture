import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.keyboardType,
    this.validator,
    this.onPressedSuffixIcon,
    this.obscureText,
    this.autofocus,
    this.border,
  }) : super(key: key);

  final TextEditingController? controller;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? hintText;
  final String? labelText;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? Function(String?)? validator;
  final void Function()? onPressedSuffixIcon;
  final bool? autofocus;
  final InputBorder? border;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus ?? false,
      controller: controller,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        // prefixIcon: Icon(prefixIcon),
        suffixIcon: IconButton(
          onPressed: onPressedSuffixIcon,
          icon: Icon(suffixIcon),
        ),
        border: border ?? const OutlineInputBorder(),
      ),
    );
  }
}
