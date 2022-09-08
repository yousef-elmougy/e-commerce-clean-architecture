import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    this.text,
    this.icon,
    this.onTap,
    this.trailing,
  }) : super(key: key);

  final String? text;
  final IconData? icon;
  final GestureTapCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text('$text', style: const TextStyle(fontSize: 20)),
        trailing: trailing ?? const Icon(Icons.arrow_forward_ios, size: 30),
        leading: Icon(
          size: 30,
          icon,
        ),
      ),
    );
  }
}
