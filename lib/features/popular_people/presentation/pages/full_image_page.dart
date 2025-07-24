import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullPersonImagePage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  const FullPersonImagePage({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.download), onPressed: () {}),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500$imageUrl',
          width: width,
          height: height,
          placeholder:
              (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              ),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
        ),
      ),
    );
  }
}
