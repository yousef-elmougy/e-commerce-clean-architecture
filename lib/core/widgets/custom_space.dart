import 'package:flutter/material.dart';
import 'package:shop_clean_architecture/core/extentions/context_extension.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.size, {Key? key}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: context.widthInPercent(size));
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.size, {Key? key}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) =>
      SizedBox(height: context.heightInPercent(size));
}
