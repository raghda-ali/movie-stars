import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: 'https://image.tmdb.org/t/p/w500$imageUrl',
      width: width,
      height: height,
      fit: fit,
      placeholder:
          (context, url) => const Center(
            child: CircularProgressIndicator(color: Colors.grey),
          ),
      errorWidget:
          (context, url, error) => const Icon(Icons.error, color: Colors.red),
    );
  }
}
