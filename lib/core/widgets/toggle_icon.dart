import 'package:flutter/material.dart';

class ToggleIcon extends StatelessWidget {
  const ToggleIcon(
      {Key? key,
      required this.onPressed,
      required this.isCheck,
      this.trueIcon,
      this.trueIconColor,
      this.falseIcon})
      : super(key: key);

  final VoidCallback? onPressed;
  final bool? isCheck;
  final IconData? trueIcon;
  final Color? trueIconColor;
  final IconData? falseIcon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: isCheck == true
          ? Icon(trueIcon ?? Icons.favorite,
              color: trueIconColor ?? Colors.red, size: 30)
          : Icon(falseIcon ?? Icons.favorite_border,
              color: Colors.grey, size: 25),
    );
  }
}

