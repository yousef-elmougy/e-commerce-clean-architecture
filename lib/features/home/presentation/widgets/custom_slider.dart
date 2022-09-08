import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  final int? itemCount;
  final ExtendedIndexedWidgetBuilder? itemBuilder;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1,
        scrollDirection: Axis.horizontal,
        autoPlay: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayInterval: const Duration(seconds: 3),
      ),
    );
  }
}
