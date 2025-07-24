import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomItemWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  final void Function() onTap;
  const CustomItemWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          placeholder:
              (context, url) => const Center(
                child: CircularProgressIndicator(color: Colors.grey),
              ),
          errorWidget:
              (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
        ),
      ),
      title: Text(title),
      subtitle: Text(subTitle),
      onTap: onTap,
    );
  }
}
