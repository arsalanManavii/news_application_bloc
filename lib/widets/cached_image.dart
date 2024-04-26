import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImage extends StatelessWidget {
  double radius;
  String imageUrl;
  BoxFit fit;
  double height;
  double width;
  CachedImage({
    super.key,
    this.radius = 0,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        height: height,
        width: width,
      ),
    );
  }
}
