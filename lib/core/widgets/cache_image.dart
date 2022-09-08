import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CacheImage extends StatelessWidget {
  const CacheImage(
      {Key? key,
      required this.image,
      this.height,
      this.width,
      this.iconSize,
      this.boxFit,
      this.imageProvider})
      : super(key: key);

  final String image;
  final ImageProvider? imageProvider;
  final double? height, width, iconSize;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: width,
      fit: boxFit,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: iconSize,
        color: Colors.red,
      ),
    );
  }
}
